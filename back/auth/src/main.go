package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/i-r-l/sage/back/auth/src/routes"
	"github.com/i-r-l/sage/back/auth/src/services"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func main() {
	// Create the server
	router := gin.Default()

	// Logger
	logger := log.Default()

	// Context for server
	ctx := context.Background()

	// Initialize the db
	db, err := mongo.NewClient(options.Client().ApplyURI(os.Getenv("AUTH_DB_URI")))

	if err != nil {
		logger.Fatalf("err: %v", err)
	}

	// Connect to the db
	err = db.Connect(ctx)
	if err != nil {
		logger.Fatalf("err: %v", err)
	}

	// Cleanup any errors
	defer func() {
		db.Disconnect(ctx)
	}()

	apple := services.NewApple()
	apnToken, err := apple.GenerateApnToken()
	if err != nil {
		logger.Println(err)
	}
	logger.Println(apnToken)

	// Grab the auth URL for a particular integration
	router.POST("/authorize", routes.HandleAuth(db))

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("AUTH_SERVICE_PORT")))
}
