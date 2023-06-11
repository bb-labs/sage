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
		logger.Printf("err initializing db: %v", err)
	}

	// Connect to the db
	err = db.Connect(ctx)
	if err != nil {
		logger.Printf("err connecting to db: %v", err)
	}

	// Cleanup any errors
	defer func() {
		db.Disconnect(ctx)
	}()

	// Initialize the hub
	hub := rtc.NewHub(db, ctx)
	go hub.Run()

	// Setup routes for sessions and
	router.POST("/chat", rtc.HandleChat(hub))
	router.GET("/session", rtc.HandleSession(upgrader, hub))

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("PORT")))
}
