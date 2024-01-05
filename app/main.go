package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"os"

	"github.com/bb-labs/sage/pb"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"google.golang.org/grpc/reflection"

	"google.golang.org/grpc"
)

type SageServer struct {
	pb.UnimplementedSageServer
	dbc *mongo.Client
}

func main() {
	// Create a context, set up logging
	ctx := context.Background()
	log.SetFlags(log.LstdFlags | log.Lshortfile)

	// Connect to db
	uri := fmt.Sprintf("mongodb://%s:%s@%s:%s",
		os.Getenv("MONGO_INITDB_ROOT_USERNAME"),
		os.Getenv("MONGO_INITDB_ROOT_PASSWORD"),
		os.Getenv("DB_SERVICE_NAME"),
		os.Getenv("DB_PORT"))

	dbc, err := mongo.NewClient(options.Client().ApplyURI(uri))
	if err != nil {
		log.Fatalf("couldn't create new mongo client: %v", err)
	}

	if err = dbc.Connect(ctx); err != nil {
		log.Fatalf("couldn't connect to mongo db: %v", err)
	}

	// Cleanup any errors
	defer func() {
		dbc.Disconnect(ctx)
	}()

	// Create the server
	listener, err := net.Listen("tcp", fmt.Sprintf(":%s", os.Getenv("APP_PORT")))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	server := grpc.NewServer()
	pb.RegisterSageServer(server, &SageServer{dbc: dbc})
	reflection.Register(server)

	log.Printf("server listening at %v", listener.Addr())
	if err := server.Serve(listener); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
