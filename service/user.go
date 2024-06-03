package main

import (
	"context"
	"fmt"
	"log"

	"github.com/bb-labs/sage/pb"
)

func (s *SageServer) CreateUser(ctx context.Context, in *pb.CreateUserRequest) (*pb.CreateUserResponse, error) {
	log.Printf("Received: %v", in)

	// Check if user already exists
	user := &pb.User{Id: in.GetUser().Id}
	err := s.DB.Model(user).WherePK().Select()
	if err == nil {
		return &pb.CreateUserResponse{User: user}, nil
	}

	// If user does not exist, create it
	_, err = s.DB.Model(in.GetUser()).Insert()
	if err != nil {
		return nil, fmt.Errorf("failed to insert user: %v", err)
	}

	// Return the user
	return &pb.CreateUserResponse{User: in.GetUser()}, nil
}

func (s *SageServer) GetUser(ctx context.Context, in *pb.GetUserRequest) (*pb.GetUserResponse, error) {
	log.Printf("Received: %v", in)

	// Check if user already exists
	user := &pb.User{Id: in.GetId()}
	err := s.DB.Model(user).WherePK().Select()
	if err != nil {
		return nil, fmt.Errorf("failed to get user: %v", err)
	}

	return &pb.GetUserResponse{User: user}, nil
}
