package main

import (
	"context"
	"log"
	"os"

	"github.com/aws/aws-sdk-go-v2/aws"
	v4 "github.com/aws/aws-sdk-go-v2/aws/signer/v4"
	"github.com/aws/aws-sdk-go-v2/service/s3"

	"github.com/bb-labs/sage/pb"
)

func (s *SageServer) CreatePresignedURL(ctx context.Context, in *pb.CreatePresignedURLRequest) (*pb.CreatePresignedURLResponse, error) {
	log.Printf("Received: %v", in)

	fileName := in.GetFileName()
	bucketName := os.Getenv("S3_REELS_BUCKET_NAME")

	var err error
	var request *v4.PresignedHTTPRequest

	switch in.Action {
	case pb.PresignAction_GET:
		request, err = s.PresignClient.PresignGetObject(ctx, &s3.GetObjectInput{Bucket: aws.String(bucketName), Key: aws.String(fileName)})
	case pb.PresignAction_PUT:
		request, err = s.PresignClient.PresignPutObject(ctx, &s3.PutObjectInput{Bucket: aws.String(bucketName), Key: aws.String(fileName)})
	case pb.PresignAction_DELETE:
		request, err = s.PresignClient.PresignDeleteObject(ctx, &s3.DeleteObjectInput{Bucket: aws.String(bucketName), Key: aws.String(fileName)})
	}

	if err != nil {
		return nil, err
	}

	return &pb.CreatePresignedURLResponse{Url: request.URL}, nil
}
