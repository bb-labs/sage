package main

import (
	"log"
	"sync"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

// ID is a sender's unique identifier
type ID string

// Message holds a recipient and some bytes
type Message struct {
	recipient ID
	data      []byte
}

func NewMessage(recipient ID, data []byte) *Message {
	return &Message{recipient: recipient, data: data}
}

// Hub maintains an inbox for all clients and routes messages
type Hub struct {
	mutex   sync.Mutex
	clients map[ID]*Client

	wire       chan *Message
	connect    chan *Client
	disconnect chan *Client

	upgrader websocket.Upgrader
}

func NewHub(upgrader websocket.Upgrader) *Hub {
	return &Hub{
		upgrader:   upgrader,
		wire:       make(chan *Message),
		clients:    make(map[ID]*Client),
		connect:    make(chan *Client),
		disconnect: make(chan *Client),
	}
}

// Client is a user connected to the hub
type Client struct {
	sender    ID
	recipient ID
	inbox     chan []byte
	conn      *websocket.Conn
}

func NewClient(sender, recipient ID, conn *websocket.Conn) *Client {
	return &Client{
		sender:    sender,
		recipient: recipient,
		conn:      conn,
		inbox:     make(chan []byte),
	}
}

// Run starts the hub: connecting and disconnecting clients, and routing messages
func (h *Hub) Run() {
	for {
		select {
		case client := <-h.connect:
			h.mutex.Lock()
			h.clients[client.sender] = client
			h.mutex.Unlock()
		case client := <-h.disconnect:
			if _, ok := h.clients[client.sender]; ok {
				h.mutex.Lock()
				close(h.clients[client.sender].inbox)
				delete(h.clients, client.sender)
				h.mutex.Unlock()
			}
		case message := <-h.wire:
			if _, ok := h.clients[message.recipient]; ok {
				h.clients[message.recipient].inbox <- message.data
			}
		}
	}
}

// ConnectUsers connects a sender to the hub
func (h *Hub) ConnectUsers(ctx *gin.Context) {
	// Upgrade the connection
	conn, err := h.upgrader.Upgrade(ctx.Writer, ctx.Request, nil)
	if err != nil {
		log.Println("error upgrading connection:", err)
		return
	}

	// Get the sender and recipient
	sender := ID(ctx.Request.Header.Get("sender"))
	recipient := ID(ctx.Request.Header.Get("recipient"))

	// Store the connection
	client := NewClient(sender, recipient, conn)
	h.connect <- client

	// Start message loops
	go h.message(client)
}

// message facilitates reading / writing with the client
func (h *Hub) message(client *Client) {
	// Read client messages and route them to the hub
	go func() {
		defer func() {
			h.disconnect <- client
			client.conn.Close()
		}()

		for {
			_, message, err := client.conn.ReadMessage()
			if err != nil {
				log.Printf("error reading message: %v", err)
				break
			}

			h.wire <- NewMessage(client.recipient, message)
		}
	}()

	// Send messages to the client from their inbox
	go func() {
		defer func() {
			client.conn.Close()
		}()

		for message := range client.inbox {
			err := client.conn.WriteMessage(websocket.BinaryMessage, message)
			if err != nil {
				log.Printf("error writing message: %v", err)
				return
			}
		}
	}()
}
