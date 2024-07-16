package main

import (
	"context"
	"fmt"
	"log"

	"github.com/bb-labs/sage/pb"
)

func (s *SageServer) LikeUser(ctx context.Context, in *pb.LikeUserRequest) (*pb.LikeUserResponse, error) {
	log.Printf("Received: %v", in)

	_, err := s.DB.Model(in.Like).Where("user_id = ? and other_user_id = ?", in.Like.UserId, in.Like.OtherUserId).SelectOrInsert()
	if err != nil {
		return nil, fmt.Errorf("failed to like user: %v", err)
	}

	return &pb.LikeUserResponse{}, nil
}

func (s *SageServer) UnlikeUser(ctx context.Context, in *pb.UnlikeUserRequest) (*pb.UnlikeUserResponse, error) {
	log.Printf("Received: %v", in)

	_, err := s.DB.Model(in.Like).Where("user_id = ? and other_user_id = ?", in.Like.UserId, in.Like.OtherUserId).Delete()
	if err != nil {
		return nil, fmt.Errorf("failed to like user: %v", err)
	}

	return &pb.UnlikeUserResponse{}, nil
}

func (s *SageServer) GetLikes(ctx context.Context, in *pb.GetLikesRequest) (*pb.GetLikesResponse, error) {
	log.Printf("Received: %v", in)

	var users []*pb.User
	_, err := s.DB.Query(&users, `SELECT users.* from users LEFT JOIN likes l1 ON users.id = l1.user_id LEFT JOIN likes l2 ON l1.user_id = l2.other_user_id AND l1.other_user_id = l2.user_id WHERE l2.user_id IS NULL AND l1.other_user_id = ?`, in.UserId)
	if err != nil {
		return nil, fmt.Errorf("failed to get likes: %v", err)
	}

	return &pb.GetLikesResponse{Likes: users}, nil
}

func (s *SageServer) GetMatches(ctx context.Context, in *pb.GetMatchesRequest) (*pb.GetMatchesResponse, error) {
	log.Printf("Received: %v", in)

	var users []*pb.User
	_, err := s.DB.Query(&users, `SELECT users.* from users LEFT JOIN likes l1 ON users.id = l1.user_id LEFT JOIN likes l2 ON l1.user_id = l2.other_user_id AND l1.other_user_id = l2.user_id WHERE users.id != ? AND l2.user_id IS NOT NULL AND l2.other_user_id IS NOT NULL`, in.UserId)
	if err != nil {
		return nil, fmt.Errorf("failed to get matches: %v", err)
	}

	return &pb.GetMatchesResponse{Matches: users}, nil
}
