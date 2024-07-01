package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"os"
	"strconv"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/bb-labs/corner"
	"github.com/bb-labs/sage/pb"
	"github.com/go-pg/pg/v10"
	"github.com/go-pg/pg/v10/orm"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

type SageServer struct {
	pb.UnimplementedSageServer
	*pg.DB
	*s3.PresignClient
}

func main() {
	// Create context
	ctx := context.Background()

	// Create a context, set up logging
	log.SetFlags(log.LstdFlags | log.Lshortfile)

	// Connect to db
	dbc := pg.Connect(&pg.Options{
		User:     os.Getenv("DB_USERNAME"),
		Password: os.Getenv("DB_PASSWORD"),
		Database: os.Getenv("DB_NAME"),
		Addr:     fmt.Sprintf("%s:%s", os.Getenv("DB_DOMAIN"), os.Getenv("DB_PORT")),
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
	skipAuthChecks, _ := strconv.ParseBool(os.Getenv("APPLE_SKIP_AUTH_CHECKS"))
	log.Printf("apple bundle id: %v", os.Getenv("APPLE_BUNDLE_ID"))
	log.Printf("apple client secret: %v", os.Getenv("APPLE_CLIENT_SECRET"))
	appleProvider, err := corner.NewAppleProvider(ctx, corner.Config{
		ClientID:     os.Getenv("APPLE_BUNDLE_ID"),
		ClientSecret: os.Getenv("APPLE_CLIENT_SECRET"),
		SkipChecks:   skipAuthChecks,
	})
	if err != nil {
		log.Fatalf("failed to create apple provider: %v", err)
	}

	// Create a new corner instance
	cb := corner.New(appleProvider)

	// Create the s3 client, for presigned URLs
	sdkConfig, err := config.LoadDefaultConfig(ctx)
	if err != nil {
		log.Fatalf("failed to load SDK config: %v", err)
	}
	s3Client := s3.NewFromConfig(sdkConfig)
	presignClient := s3.NewPresignClient(s3Client)

	// Create the grpc server
	server := grpc.NewServer(grpc.ChainUnaryInterceptor(cb.UnaryServerInterceptor))
	defer func() {
		server.GracefulStop()
	}()

	// Register the server
	pb.RegisterSageServer(server, &SageServer{DB: dbc, PresignClient: presignClient})
	reflection.Register(server)

	// Create the tcp connection
	listener, err := net.Listen("tcp", fmt.Sprintf(":%s", os.Getenv("APP_CONTAINER_PORT")))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	// And serve
	log.Printf("server is listening at %v", listener.Addr())
	if err := server.Serve(listener); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
