package rtc

import (
	"context"
	"log"
	"os"

	sageproto "github.com/i-r-l/sage/back/wss/protos"
	"go.mongodb.org/mongo-driver/mongo"
)

// Hub maintains the set of active clients and broadcasts messages to the
// clients.
type Hub struct {
	// Registered clients.
	clients map[string]*Client

	// Routing map for client comms
	routing map[string]string

	// Inbound messages from the clients.
	incoming chan *Message

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

func NewHub(db *mongo.Client, ctx context.Context) *Hub {
	return &Hub{
		incoming:   make(chan *Message),
		register:   make(chan *Client),
		unregister: make(chan *Client),
		clients:    make(map[string]*Client),
		routing:    make(map[string]string),
		db:         db,
		ctx:        ctx,
		logger:     log.Default(),
	}
}

func (h *Hub) Store(chatReq *sageproto.ChatRequest, inMem bool) (*mongo.InsertOneResult, error) {
	h.logger.Println("storing: ", chatReq)

	if inMem {
		h.routing[chatReq.User.Id] = chatReq.OtherUser.Id
		h.routing[chatReq.OtherUser.Id] = chatReq.User.Id

		return nil, nil
	}

	return h.db.Database(os.Getenv("MONGO_DB_NAME")).Collection("webRtc").InsertOne(h.ctx, chatReq)
}

func (h *Hub) UnregisterClient(client *Client) {
	delete(h.clients, client.ID)
	close(client.send)
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
		case message := <-h.incoming:
			if _, ok := h.routing[message.Client.ID]; !ok {
				h.logger.Printf("err: sending client %s not in routing table", message.Client.ID)
				continue
			}

			recvClientID := h.routing[message.Client.ID]

			if _, ok := h.clients[recvClientID]; !ok {
				h.logger.Printf("err: receiving client %s is not registered", recvClientID)
				continue
			}

			recvClient := h.clients[recvClientID]
			recvClient.send <- message.Data
		}
	}
}
