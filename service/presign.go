package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/s3"

	"github.com/bb-labs/sage/pb"
)

func (s *SageServer) CreatePresignedURL(ctx context.Context, in *pb.CreatePresignedURLRequest) (*pb.CreatePresignedURLResponse, error) {
	log.Printf("Received: %v", in)

	fileName := in.GetFileName()
	bucketName := os.Getenv("S3_REELS_BUCKET_NAME")

	switch in.Action {
	case pb.Action_GET:
		request, err := s.PresignClient.PresignGetObject(ctx, &s3.GetObjectInput{Bucket: aws.String(bucketName), Key: aws.String(fileName)})
		return &pb.CreatePresignedURLResponse{Url: request.URL}, err
	case pb.Action_PUT:
		request, err := s.PresignClient.PresignPutObject(ctx, &s3.PutObjectInput{Bucket: aws.String(bucketName), Key: aws.String(fileName)})
		return &pb.CreatePresignedURLResponse{Url: request.URL}, err
	case pb.Action_DELETE:
		request, err := s.PresignClient.PresignDeleteObject(ctx, &s3.DeleteObjectInput{Bucket: aws.String(bucketName), Key: aws.String(fileName)})
		return &pb.CreatePresignedURLResponse{Url: request.URL}, err
	}

	return nil, fmt.Errorf("unknown action: %v", in.Action)
}
