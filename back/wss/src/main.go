package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
	"github.com/i-r-l/sage/back/wss/src/rtc"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func main() {
	// Create the server
	router := gin.Default()
	upgrader := websocket.Upgrader{}

	// Logger
	logger := log.Default()

	// Context for server
	ctx := context.Background()

	// Initialize the db
	db, err := mongo.NewClient(options.Client().ApplyURI(os.Getenv("MONGO_URI")))

	if err != nil {
		logger.Fatalf("err initializing db: %v", err)
	}

	// Connect to the db
	err = db.Connect(ctx)
	if err != nil {
		logger.Fatalf("err connecting to db: %v", err)
	}

	// Cleanup any errors
	defer func() {
		db.Disconnect(ctx)
	}()

	// Initialize the hub
	hub, err := rtc.NewHub(db, ctx)
	if err != nil {
		logger.Fatalf("err initializing hub: %v", err)
	}
	go hub.Run()

	// Setup routes for sessions and
	router.POST("/route", rtc.HandleRoute(hub))
	router.GET("/session", rtc.HandleSession(upgrader, hub))

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("PORT")))
}
