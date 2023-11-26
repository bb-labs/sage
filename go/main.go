package main

import (
	"fmt"
	"log"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	// Create the server
	router := gin.Default()
	log.SetFlags(log.LstdFlags | log.Lshortfile)

	// Test route for health check
	router.GET("/ping", func(c *gin.Context) {
		log.Println("ping")
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("APP_PORT")))
}
