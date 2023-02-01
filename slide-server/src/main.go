package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/i-r-l/slide/src/routes"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func main() {
	// Create the server
	router := gin.Default()

	// Logger
	logger := log.Default()

	// Initialize the db
	fmt.Println("Mongo URI: ", os.Getenv("MONGO_URI"))
	fmt.Println("Mongo DB: ", os.Getenv("MONGO_DB_NAME"))

	db, err := mongo.NewClient(options.Client().ApplyURI(os.Getenv("MONGO_URI")))

	if err != nil {
		logger.Fatalf("err: %v", err)
	}

	ctx, cancelFn := context.WithTimeout(context.Background(), 10*time.Second)

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
	router.POST("/locate", routes.HandleLocation(db))

	// Run the server
	router.Run(":3000")
}
