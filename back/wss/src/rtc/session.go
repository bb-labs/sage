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
			logger.Println(err)
			conn.Close()
			return
		}

		client := &Client{
			ID:     ctx.Query("deviceToken"),
			conn:   conn,
			send:   make(chan []byte, 1024*512),
			logger: log.Default(),
		}

		hub.register <- client

		go client.writePump(hub)
		go client.readPump(hub)
	}
}
