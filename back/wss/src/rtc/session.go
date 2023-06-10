package rtc

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

func HandleSession(upgrader websocket.Upgrader, hub *Hub) func(*gin.Context) {
	return func(ctx *gin.Context) {
		logger := log.Default()

		conn, err := upgrader.Upgrade(ctx.Writer, ctx.Request, nil)

		if err != nil {
			logger.Fatalln(err)
			return
		}

		client := &Client{hub: hub, conn: conn, send: make(chan []byte, 1024*4)}
		hub.register <- client

		go client.writePump()
		go client.readPump()
	}
}
