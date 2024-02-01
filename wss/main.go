package main

import (
	"fmt"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

func main() {
	// Create the server
	router := gin.Default()

	// Initialize the hub
	hub := NewHub(websocket.Upgrader{})

	// Setup route to connect users
	router.POST("/connect", hub.ConnectUsers(hub, "1234", "5678"))

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("PORT")))
}
