package signaling

import (
	"context"
	"log"
	"os"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"

	sageproto "github.com/bb-labs/sage/protos"
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
	}

	err := hub.initRouter()

	if err != nil {
		return nil, err
	}

	return hub, nil
}

func (h *Hub) initRouter() error {
	routerCur, err := h.db.Database(os.Getenv("MONGO_INITDB_DATABASE")).Collection(os.Getenv("DB_SIGNALING_COLLECTION")).Find(h.ctx, bson.D{})

	if err != nil {
		log.Fatalf("err: %v. failed to fetch routing table", err)
		return nil
	}

	results := []*sageproto.RouteRequest{}
	err = routerCur.All(h.ctx, &results)

	if err != nil {
		log.Fatalf("err: %v. failed to fetch routing table", err)
		return err
	}

	for _, entry := range results {
		h.router[entry.Id] = entry.OtherId
		h.router[entry.OtherId] = entry.Id
	}

	return nil
}

func (h *Hub) Store(routeReq *sageproto.RouteRequest) (*mongo.InsertOneResult, error) {
	res, err := h.db.Database(os.Getenv("MONGO_INITDB_DATABASE")).Collection("DB_SIGNALING_COLLECTION").InsertOne(h.ctx, routeReq)

	log.Printf("res: %v", res)
	log.Printf("stored route request: %v", routeReq)

	if err != nil {
		return nil, err
	}

	h.router[routeReq.Id] = routeReq.OtherId
	h.router[routeReq.OtherId] = routeReq.Id

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
