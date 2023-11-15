package rtc

import (
	"log"

	"github.com/gorilla/websocket"
)

// Client is a middleman between the websocket connection and the hub.
type Client struct {
	// ID of the client
	ID string

	// The websocket connection.
	conn *websocket.Conn

	// Buffered channel of outbound messages.
	send chan *Message
}

func (c *Client) readPump(hub *Hub) {
	defer func() {
		hub.unregister <- c
		c.conn.Close()
	}()

	for {
		_, message, err := c.conn.ReadMessage()

		if err != nil {
			log.Printf("error: %v", err)
			return
		}

		log.Println("Client: ", c.ID)

		hub.wire <- &Message{Data: &message, Client: c}
	}
}

func (c *Client) writePump(hub *Hub) {
	defer func() {
		c.conn.Close()
	}()

	for {
		message, ok := <-c.send

		if !ok {
			c.conn.WriteMessage(websocket.CloseMessage, []byte{})
			return
		}

		c.conn.WriteMessage(websocket.BinaryMessage, *message.Data)
	}
}
