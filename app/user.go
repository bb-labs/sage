package main

import (
	"context"
	"fmt"
	"log"

	"github.com/bb-labs/sage/pb"
	"google.golang.org/grpc/metadata"
)

func (s *SageServer) CreateUser(ctx context.Context, in *pb.CreateUserRequest) (*pb.CreateUserResponse, error) {
	log.Printf("Received: %v", in)
	md, _ := metadata.FromIncomingContext(ctx)
	log.Printf("Metadata: %v", md)

	_, err := s.dbc.Model(in.GetUser()).Insert()
	if err != nil {
		return nil, fmt.Errorf("failed to insert user: %v", err)
	}

	return &pb.CreateUserResponse{User: in.GetUser()}, nil
}
