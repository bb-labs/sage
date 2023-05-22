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
	"github.com/i-r-l/sage/back/presign/src/routes"
)

func main() {
	// Create the server
	router := gin.Default()

	// Logger
	logger := log.Default()

	// Context for server
	ctx, cancelFn := context.WithTimeout(context.Background(), 30*time.Second)

	// Connect to S3
	sdkConfig, err := config.LoadDefaultConfig(ctx)
	if err != nil {
		logger.Fatalf("err: %v", err)
	}

	s3Client := s3.NewFromConfig(sdkConfig)
	presignClient := s3.NewPresignClient(s3Client)

	// Cleanup any errors
	defer func() {
		cancelFn()
	}()

	router.GET("/presign", routes.HandlePresign(presignClient))

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("PORT")))
}
