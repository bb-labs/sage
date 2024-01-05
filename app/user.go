package main

import (
	"context"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"os"

	"github.com/bb-labs/sage/pb"
	"go.mongodb.org/mongo-driver/bson"
	"google.golang.org/protobuf/encoding/protojson"
)

func (s *SageServer) CreateUser(ctx context.Context, in *pb.CreateUserRequest) (*pb.CreateUserResponse, error) {
	log.Printf("Received: %v", in)

	_, err := s.dbc.Database(os.Getenv("MONGO_INITDB_DATABASE")).Collection(os.Getenv("DB_USERS_COLLECTION")).InsertOne(ctx, bson.M{
		"_id":   in.GetUser().GetId(),
		"email": in.GetUser().GetEmail(),
	})
	if err != nil {
		return nil, fmt.Errorf("err inserting user: %v", err)
	}

	resp, err := http.PostForm(os.Getenv("APPLE_TOKEN_URL"), url.Values{
		"client_id":     {os.Getenv("APPLE_BUNDLE_ID")},
		"client_secret": {os.Getenv("APPLE_CLIENT_SECRET")},
		"grant_type":    {"authorization_code"},
		"code":          {in.GetToken().GetAuthCode()},
	})
	if err != nil {
		return nil, fmt.Errorf("err getting auth token from apple: %v", err)
	}

	token := pb.Token{}
	buf, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("err reading response body: %v", err)
	}

	if err := protojson.Unmarshal(buf, &token); err != nil {
		return nil, fmt.Errorf("err parsing token: %v", err)
	}

	return &pb.CreateUserResponse{Token: &token}, nil
}
