package main

import (
	"context"
	"fmt"
	"log"

	"github.com/bb-labs/corner"
	"github.com/bb-labs/sage/pb"
	"golang.org/x/sync/errgroup"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (s *SageServer) CreateUser(ctx context.Context, in *pb.CreateUserRequest) (*pb.CreateUserResponse, error) {
	log.Printf("Received: %v", in)

	_, err := s.dbc.Model(in.GetUser()).Insert()
	if err != nil {
		return nil, fmt.Errorf("failed to insert user: %v", err)
	}

	return &pb.CreateUserResponse{User: in.GetUser()}, nil
}

func (s *SageServer) MessageUser(stream pb.Sage_MessageUserServer) error {
	errs, ctx := errgroup.WithContext(stream.Context())
	userID := ctx.Value(corner.AuthTokenHeader).(string)

	// Retrieve messages from inbox
	errs.Go(func() error {
		s.Mutex.Lock()
		if _, ok := s.Inbox[userID]; !ok {
			s.Inbox[userID] = make(chan *pb.Message)
		}
		s.Mutex.Unlock()

		for {
			select {
			case <-ctx.Done():
			case message := <-s.Inbox[userID]:
				if s, ok := status.FromError(stream.Send(message)); ok {
					switch s.Code() {
					case codes.OK:
					case codes.Unavailable, codes.Canceled, codes.DeadlineExceeded:
					default:
						return s.Err()
					}
				}
			}
		}
	})

	// Store incoming messages in user inboxes
	errs.Go(func() error {
		for {
			request, err := stream.Recv()
			if err != nil {
				return err
			}

			recID := request.GetRecipient().GetId()

			s.Mutex.Lock()
			if _, ok := s.Inbox[recID]; !ok {
				s.Inbox[recID] = make(chan *pb.Message)
			}
			for _, message := range request.GetMessages() {
				s.Inbox[recID] <- message
			}
			s.Mutex.Unlock()
		}
	})

	return errs.Wait()
}
