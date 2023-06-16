package rtc

import (
	"log"

	"github.com/golang/protobuf/proto"
	"github.com/gorilla/websocket"
	sageproto "github.com/i-r-l/sage/back/wss/protos"
)

// Client is a middleman between the websocket connection and the hub.
type Client struct {
	// ID of the client
	ID string

	// The websocket connection.
	conn *websocket.Conn

	// Buffered channel of outbound messages.
	send chan *Message

	// Logger for the client
	logger *log.Logger
}

// readPump pumps messages from the websocket connection to the hub.
//
// The application runs readPump in a per-connection goroutine. The application
// ensures that there is at most one reader on a connection by executing all
// reads from this goroutine.
func (c *Client) readPump(hub *Hub) {
	defer func() {
		hub.unregister <- c
		c.conn.Close()
	}()

	for {
		_, message, err := c.conn.ReadMessage()

		if err != nil {
			c.logger.Printf("error: %v", err)
			return
		}

		c.logger.Println("Client: ", c.ID)

		hub.wire <- &Message{Data: &message, Client: c}
	}
}

// writePump pumps messages from the hub to the websocket connection.
//
// A goroutine running writePump is started for each connection. The
// application ensures that there is at most one writer to a connection by
// executing all writes from this goroutine.
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

		request := sageproto.SignalingRequest{}
		err := proto.Unmarshal(*message.Data, &request)
		if err != nil {
			c.logger.Println("err: ", err)
		} else if request.GetIce() != nil {
			c.logger.Println("Ice: ", request.GetIce())
		} else {
			c.logger.Println("Sdp: ", request.GetSdp())
		}

		c.conn.WriteMessage(websocket.BinaryMessage, *message.Data)
	}
}
