package main

import (
	"fmt"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
	"github.com/i-r-l/sage/back/wss/src/routes"
)

func main() {
	// Create the server
	router := gin.Default()
	upgrader := websocket.Upgrader{}

	// Grab the auth URL for a particular integration
	router.GET("/session", routes.HandleSession(upgrader))

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("PORT")))
}
