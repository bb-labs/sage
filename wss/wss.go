package main

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

// Hub maintains an inbox for all clients and routes messages
type Hub struct {
	// All incoming messages from the clients.
	Inbox map[string]chan []byte

	Upgrader websocket.Upgrader
}

// NewHub creates a new hub
func NewHub(upgrader websocket.Upgrader) *Hub {
	return &Hub{
		Inbox:    make(map[string]chan []byte),
		Upgrader: upgrader,
	}
}

// ConnectUsers connects two users
func (h *Hub) ConnectUsers(hub *Hub, sID, rID string) func(*gin.Context) {
	return func(ctx *gin.Context) {
		// Upgrade the connection
		conn, err := h.Upgrader.Upgrade(ctx.Writer, ctx.Request, nil)
		if err != nil {
			conn.Close()
			return
		}

		go h.connect(conn, sID, rID)
	}
}

// connect facilitates reading and writing messages between two users
func (h *Hub) connect(conn *websocket.Conn, sID, rID string) {
	defer func() { conn.Close() }()

	// Read client messages, store them in the recipient's inbox
	go func() {
		for {
			_, message, err := conn.ReadMessage()
			if err != nil {
				log.Printf("error: %v", err)
				return
			}

			if _, ok := h.Inbox[rID]; !ok {
				h.Inbox[rID] = make(chan []byte)
			}

			h.Inbox[rID] <- message
		}
	}()

	// Send messages to the client from their inbox
	go func() {
		for message := range h.Inbox[sID] {
			err := conn.WriteMessage(websocket.BinaryMessage, message)
			if err != nil {
				log.Printf("error: %v", err)
				return
			}

			conn.WriteMessage(websocket.BinaryMessage, message)
		}
	}()
}
