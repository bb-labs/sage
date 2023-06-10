package main

import (
	"fmt"
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
	"github.com/i-r-l/sage/back/wss/src/routes"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func main() {
	// Create the server
	router := gin.Default()
	upgrader := websocket.Upgrader{}

	// Logger
	logger := log.Default()

	// Initialize the db
	db, err := mongo.NewClient(options.Client().ApplyURI(os.Getenv("MONGO_URI")))

	if err != nil {
		logger.Fatalf("err: %v", err)
	}

	// Grab the auth URL for a particular integration
	router.GET("/session", routes.HandleSession(upgrader, db))

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("PORT")))
}
