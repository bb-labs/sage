package main

import (
	"context"
	"fmt"
	"log"

	"github.com/bb-labs/sage/pb"
)

func (s *SageServer) GetFeed(ctx context.Context, in *pb.GetFeedRequest) (*pb.GetFeedResponse, error) {
	log.Printf("Received: %v", in)

	var users []*pb.User
	err := s.DB.Model(&users).Select()
	if err != nil {
		return nil, fmt.Errorf("failed to get feed: %v", err)
	}

	return &pb.GetFeedResponse{Feed: &pb.Feed{Users: users}}, nil
}
