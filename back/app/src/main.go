package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/i-r-l/sage/back/app/src/routes"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func main() {
	// Create the server
	router := gin.Default()

	// Logger
	logger := log.Default()

	// Context for server
	ctx, cancelFn := context.WithTimeout(context.Background(), 30*time.Second)

	// Initialize the db
	db, err := mongo.NewClient(options.Client().ApplyURI(os.Getenv("APP_DB_URI")))

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
		cancelFn()
	}()

	// Grab the auth URL for a particular integration
	router.POST("/user", routes.HandleCreateUser(db))
	router.POST("/locate", routes.HandleLocation(db))

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("APP_SERVICE_PORT")))
}
