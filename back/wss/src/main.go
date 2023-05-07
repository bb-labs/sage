package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
	"github.com/i-r-l/sage/wss/routes"
)

func main() {
	// Create the server
	router := gin.Default()
	upgrader := websocket.Upgrader{}

	// Context for server
	ctx, cancelFn := context.WithTimeout(context.Background(), 30*time.Second)

	// Cleanup any errors
	defer func() {
		cancelFn()
	}()

	// Grab the auth URL for a particular integration
	router.GET("/session", routes.HandleSession(upgrader))

	// Run the server
	router.Run(fmt.Sprintf(":%s", os.Getenv("PORT")))
}
