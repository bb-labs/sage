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
	go hub.Run()

	// Setup route to connect users
	router.GET("/connect", hub.ConnectUsers())

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("WSS_PORT")))
}
