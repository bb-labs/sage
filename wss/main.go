package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/bb-labs/corner"
	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

func main() {
	// Create the server
	ctx := context.Background()
	router := gin.Default()

	// Create an apple OIDC provider
	appleProvider, err := corner.NewAppleProvider(ctx, os.Getenv("APPLE_BUNDLE_ID"), os.Getenv("APPLE_CLIENT_SECRET"))
	if err != nil {
		log.Fatalf("failed to create apple provider: %v", err)
	}

	// Create a new corner instance
	cb := corner.New(appleProvider)

	// Add authentication middleware
	router.Use(cb.GinAuthenticator)

	// Initialize the hub
	hub := NewHub(websocket.Upgrader{})
	go hub.Run()

	// Setup route to connect users
	router.GET("/connect", hub.ConnectUsers)

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("WSS_PORT")))
}
