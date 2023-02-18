package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
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

	// Context for server
	ctx, cancelFn := context.WithTimeout(context.Background(), 30*time.Second)

	// Initialize the db
	db, err := mongo.NewClient(options.Client().ApplyURI(os.Getenv("MONGO_URI")))

	if err != nil {
		logger.Fatalf("err: %v", err)
	}

	// Connect to the db
	err = db.Connect(ctx)
	if err != nil {
		logger.Fatalf("err: %v", err)
	}

	// Connect to S3
	sdkConfig, err := config.LoadDefaultConfig(ctx)
	if err != nil {
		logger.Fatalf("err: %v", err)
	}

	s3Client := s3.NewFromConfig(sdkConfig)
	presignClient := s3.NewPresignClient(s3Client)

	// Cleanup any errors
	defer func() {
		db.Disconnect(ctx)
		cancelFn()
	}()

	// Grab the auth URL for a particular integration
	router.POST("/locate", routes.HandleLocation(db))
	router.GET("/presign", routes.HandlePresign(presignClient))

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("PORT")))
}
