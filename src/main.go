package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/bb-labs/sage/src/presign"
	"github.com/bb-labs/sage/src/user"
	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"

	rtc "github.com/bb-labs/sage/src/signaling"
)

func main() {
	// Create the server
	router := gin.Default()
	upgrader := websocket.Upgrader{}

	// Logger
	log.SetFlags(log.LstdFlags | log.Lshortfile)

	// Context for server
	ctx := context.Background()

	// Initialize the db
	uri := fmt.Sprintf("mongodb://%s:%s@%s:%s",
		os.Getenv("MONGO_INITDB_ROOT_USERNAME"),
		os.Getenv("MONGO_INITDB_ROOT_PASSWORD"),
		os.Getenv("DB_CONTAINER_NAME"),
		os.Getenv("DB_PORT"))

	db, err := mongo.NewClient(options.Client().ApplyURI(uri))

	if err != nil {
		log.Fatalf("err: %v", err)
	}

	// Connect to the db
	err = db.Connect(ctx)
	if err != nil {
		log.Fatalf("err: %v", err)
	}

	// Initialize the signaling hub
	hub, err := rtc.NewHub(db, ctx)
	if err != nil {
		log.Fatalf("err initializing hub: %v", err)
	}
	go hub.Run()

	// Connect to S3 for presigning
	sdkConfig, err := config.LoadDefaultConfig(ctx)
	if err != nil {
		log.Fatalf("err: %v", err)
	}

	s3Client := s3.NewFromConfig(sdkConfig)
	presignClient := s3.NewPresignClient(s3Client)

	// Cleanup any errors
	defer func() {
		db.Disconnect(ctx)
	}()

	// Test route for health check
	router.GET("/ping", func(c *gin.Context) {
		log.Println("ping")
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	// Setup routes for user actions
	router.POST("/user", user.HandleCreateUser(db))
	router.POST("/locate", user.HandleLocation(db))

	// Setup routes for presigning
	router.GET("/presign", presign.HandlePresign(presignClient))

	// Setup routes for sessions and wss routing
	router.POST("/route", rtc.HandleRoute(hub))
	router.GET("/session", rtc.HandleSession(upgrader, hub))

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("APP_PORT")))
}
