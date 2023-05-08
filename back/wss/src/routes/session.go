package routes

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

func HandleSession(upgrader websocket.Upgrader) func(*gin.Context) {
	return func(ctx *gin.Context) {
		// Logger
		logger := log.Default()

		// upgrade HTTP connection to WebSocket
		conn, err := upgrader.Upgrade(ctx.Writer, ctx.Request, nil)
		if err != nil {
			log.Println(err)
			return
		}
		defer conn.Close()

		// infinite loop to read messages from client
		for {
			// read message from client
			_, msg, err := conn.ReadMessage()
			if err != nil {
				log.Println(err)
				return
			}

			logger.Printf("Received message: %s\n", msg)

			// send message back to client
			err = conn.WriteMessage(websocket.TextMessage, []byte("What a nice message, thank you!"))
			if err != nil {
				log.Println(err)
				return
			}
		}
	}
}
