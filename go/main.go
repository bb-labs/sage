package main

import (
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
			"env": os.Environ(),
		})
	})

	// Run the server
	router.Run(":3000")
}
