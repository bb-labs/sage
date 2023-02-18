package routes

import (
	"context"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	v4 "github.com/aws/aws-sdk-go-v2/aws/signer/v4"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/gin-gonic/gin"
)

// Presigner encapsulates the Amazon Simple Storage Service (Amazon S3) presign actions
// used in the examples.
// It contains PresignClient, a client that is used to presign requests to Amazon S3.
// Presigned requests contain temporary credentials and can be made from any HTTP client.
type Presigner struct {
	PresignClient *s3.PresignClient
}

// GetObject makes a presigned request that can be used to get an object from a bucket.
// The presigned request is valid for the specified number of seconds.
func (presigner Presigner) GetObject(objectKey string, context context.Context) (*v4.PresignedHTTPRequest, error) {
	request, err := presigner.PresignClient.PresignGetObject(context, &s3.GetObjectInput{
		Bucket: aws.String(os.Getenv("S3_BUCKET_NAME")),
		Key:    aws.String(objectKey),
	}, func(opts *s3.PresignOptions) {
		opts.Expires = time.Duration(60 * 5 * int64(time.Second)) // 5 minutes
	})

	if err != nil {
		log.Printf("Couldn't get a presigned request to get %v:%v. error: %v\n", os.Getenv("S3_BUCKET_NAME"), objectKey, err)
	}

	return request, err
}

// PutObject makes a presigned request that can be used to put an object in a bucket.
// The presigned request is valid for the specified number of seconds.
func (presigner Presigner) PutObject(objectKey string, context context.Context) (*v4.PresignedHTTPRequest, error) {
	request, err := presigner.PresignClient.PresignPutObject(context, &s3.PutObjectInput{
		Bucket: aws.String(os.Getenv("S3_BUCKET_NAME")),
		Key:    aws.String(objectKey),
	}, func(opts *s3.PresignOptions) {
		opts.Expires = time.Duration(60 * 5 * int64(time.Second)) // 5 minutes
	})

	if err != nil {
		log.Printf("Couldn't get a presigned request to put %v:%v. error: %v\n", os.Getenv("S3_BUCKET_NAME"), objectKey, err)
	}

	return request, err
}

// DeleteObject makes a presigned request that can be used to delete an object from a bucket.
func (presigner Presigner) DeleteObject(objectKey string, context context.Context) (*v4.PresignedHTTPRequest, error) {
	request, err := presigner.PresignClient.PresignDeleteObject(context, &s3.DeleteObjectInput{
		Bucket: aws.String(os.Getenv("S3_BUCKET_NAME")),
		Key:    aws.String(objectKey),
	})

	if err != nil {
		log.Printf("Couldn't get a presigned request to delete object %v. Here's why: %v\n", objectKey, err)
	}

	return request, err
}

func HandlePresign(client *s3.PresignClient) func(*gin.Context) {
	return func(ctx *gin.Context) {
		presigner := Presigner{PresignClient: client}
		key := ctx.Query("key")
		action := ctx.Query("action")

		var err error
		var request *v4.PresignedHTTPRequest

		switch action {
		case "GET":
			request, err = presigner.GetObject(key, ctx)
		case "PUT":
			request, err = presigner.PutObject(key, ctx)
		case "DELETE":
			request, err = presigner.DeleteObject(key, ctx)
		}

		if err != nil {
			log.Printf("Couldn't get a presigned request for %v. error: %v\n", os.Getenv("S3_BUCKET_NAME"), err)
		}

		ctx.String(http.StatusOK, request.URL)
	}
}
