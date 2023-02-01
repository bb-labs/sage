package main

import (
	"context"
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

	// Initialize the db
	db, _ := mongo.NewClient(options.Client().ApplyURI(os.Getenv("MONGO_URI")))
	ctx, cancelFn := context.WithTimeout(context.Background(), 10*time.Second)

	// Connect to the db
	db.Connect(ctx)

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
