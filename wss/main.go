package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"strconv"

	"github.com/bb-labs/corner"
	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

func main() {
	// Create the server
	ctx := context.Background()
	router := gin.Default()

	// Add the apple oauth2 provider
	skipAuthChecks, _ := strconv.ParseBool(os.Getenv("APPLE_SKIP_AUTH_CHECKS"))
	appleProvider, err := corner.NewAppleProvider(ctx, corner.Config{
		ClientID:     os.Getenv("APPLE_BUNDLE_ID"),
		ClientSecret: os.Getenv("APPLE_CLIENT_SECRET"),
		SkipChecks:   skipAuthChecks,
	})
	if err != nil {
		log.Fatalf("failed to create apple provider: %v", err)
	}

	// Create a new corner instance
	cb := corner.New(appleProvider)

	// Initialize the hub
	hub := NewHub(websocket.Upgrader{})
	go hub.Run()

	// Routes
	public := router.Group("/")
	public.GET("/health", func(c *gin.Context) { c.JSON(200, gin.H{"status": "healthy!"}) })

	private := router.Group("/")
	private.Use(cb.GinAuthenticator)
	private.GET("/connect", hub.ConnectUsers)

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("WSS_CONTAINER_PORT")))
}
