package rtc

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

func HandleSession(upgrader websocket.Upgrader, hub *Hub) func(*gin.Context) {
	return func(ctx *gin.Context) {
		logger := log.Default()

		clientID := ctx.Query("deviceToken")

		if _, ok := hub.router[clientID]; !ok {
			hub.logger.Printf("err: no receiving client found for %s", clientID)
			return
		}

		conn, err := upgrader.Upgrade(ctx.Writer, ctx.Request, nil)

		if err != nil {
			logger.Println(err)
			conn.Close()
			return
		}

		client := &Client{
			ID:     ctx.Query("deviceToken"),
			conn:   conn,
			send:   make(chan *Message),
			logger: log.Default(),
		}

		hub.register <- client

		go client.writePump(hub)
		go client.readPump(hub)
	}
}
