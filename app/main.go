package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"os"

	"github.com/bb-labs/corner"
	"github.com/bb-labs/sage/pb"
	"github.com/go-pg/pg/v10"
	"github.com/go-pg/pg/v10/orm"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

type SageServer struct {
	pb.UnimplementedSageServer
	dbc *pg.DB
}

func main() {
	// Create context
	ctx := context.Background()

	// Create a context, set up logging
	log.SetFlags(log.LstdFlags | log.Lshortfile)

	// Connect to db
	dbc := pg.Connect(&pg.Options{
		User:     os.Getenv("POSTGRES_USER"),
		Password: os.Getenv("POSTGRES_PASSWORD"),
		Database: os.Getenv("POSTGRES_DB"),
		Addr:     fmt.Sprintf("%s:%s", os.Getenv("DB_HOST"), os.Getenv("DB_PORT")),
	})
	defer dbc.Close()

	// Create the db schema
	for _, model := range []interface{}{(*pb.User)(nil), (*pb.Token)(nil)} {
		err := dbc.Model(model).CreateTable(&orm.CreateTableOptions{
			IfNotExists:   true,
			FKConstraints: true,
		})
		if err != nil {
			log.Fatalf("failed to create table: %v", err)
		}
	}

	// Add the apple oauth2 provider
	appleProvider, err := corner.NewProvider(ctx, corner.AppleProviderURL, os.Getenv("APPLE_BUNDLE_ID"), os.Getenv("APPLE_CLIENT_SECRET"))
	if err != nil {
		log.Fatalf("failed to create apple provider: %v", err)
	}

	// Create a new corner instance
	corner := corner.New(appleProvider)

	// Create the grpc server
	server := grpc.NewServer(
		grpc.ChainUnaryInterceptor(corner.UnaryServerInterceptor),
	)
	defer func() {
		server.GracefulStop()
	}()

	// Register the server
	pb.RegisterSageServer(server, &SageServer{dbc: dbc})
	reflection.Register(server)

	// Create the tcp connection
	listener, err := net.Listen("tcp", fmt.Sprintf(":%s", os.Getenv("APP_PORT")))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	// And serve
	log.Printf("server is listening at %v", listener.Addr())
	if err := server.Serve(listener); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
