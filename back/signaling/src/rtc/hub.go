package rtc

import (
	"context"
	"log"
	"os"

	sageproto "github.com/i-r-l/sage/back/signaling/protos"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)

// Hub maintains the set of active clients and broadcasts messages to the
// clients.
type Hub struct {
	// Routing map for client comms
	router map[string]string

	// All incoming message to the hub
	wire chan *Message

	// Registered clients.
	clients map[string]*Client

	// Register requests from the clients.
	register chan *Client

	// Unregister requests from clients.
	unregister chan *Client

	// Context for db
	ctx context.Context

	// Database to store client records
	db *mongo.Client

	// Logger
	logger *log.Logger
}

func NewHub(db *mongo.Client, ctx context.Context) (*Hub, error) {
	hub := &Hub{
		db:         db,
		ctx:        ctx,
		wire:       make(chan *Message),
		router:     make(map[string]string),
		register:   make(chan *Client),
		unregister: make(chan *Client),
		clients:    make(map[string]*Client),
		logger:     log.Default(),
	}

	err := hub.initRouter()

	if err != nil {
		return nil, err
	}

	return hub, nil
}

func (h *Hub) initRouter() error {
	routerCur, err := h.db.Database(os.Getenv("SIGNALING_MONGO_DB_NAME")).Collection("webRtc").Find(h.ctx, bson.D{})

	if err != nil {
		h.logger.Fatalf("err: %v. failed to fetch routing table", err)
		return nil
	}

	results := []*sageproto.RouteRequest{}
	err = routerCur.All(h.ctx, &results)

	if err != nil {
		h.logger.Fatalf("err: %v. failed to fetch routing table", err)
		return err
	}

	for _, entry := range results {
		h.router[entry.Id] = entry.OtherId
		h.router[entry.OtherId] = entry.Id
	}

	return nil
}

func (h *Hub) Store(chatReq *sageproto.RouteRequest) (*mongo.InsertOneResult, error) {
	res, err := h.db.Database(os.Getenv("SIGNALING_MONGO_DB_NAME")).Collection("webRtc").InsertOne(h.ctx, chatReq)

	if err != nil {
		return nil, err
	}

	h.router[chatReq.Id] = chatReq.OtherId
	h.router[chatReq.OtherId] = chatReq.Id

	return res, nil
}

func (h *Hub) UnregisterClient(client *Client) {
	if _, ok := h.clients[client.ID]; ok {
		delete(h.clients, client.ID)
		close(client.send)
	}
}

func (h *Hub) Run() {
	for {
		select {
		case client := <-h.register:
			h.clients[client.ID] = client
		case client := <-h.unregister:
			if _, ok := h.clients[client.ID]; ok {
				h.UnregisterClient(client)
			}
		case message := <-h.wire:
			h.clients[h.router[message.Client.ID]].send <- message
		}
	}
}
