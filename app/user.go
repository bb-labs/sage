package main

import (
	"context"
	"fmt"
	"log"

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
	errs, _ := errgroup.WithContext(stream.Context())
	userID := "1234"

	// Retrieve messages from inbox
	errs.Go(func() error {
		s.mutex.Lock()
		if _, ok := s.inbox[userID]; !ok {
			s.inbox[userID] = make(chan *pb.Message)
		}
		s.mutex.Unlock()

		for message := range s.inbox[userID] {
			log.Println("Sending message to user: ", len(message.String()))

			s, ok := status.FromError(stream.Send(message))
			if !ok {
				log.Println("Failed to send message to user: ", s.Err())
			}

			log.Println("Sent message to user: ", s.Code(), s.Err())

			switch s.Code() {
			case codes.OK:
			case codes.Unavailable, codes.Canceled, codes.DeadlineExceeded:
			default:
				return s.Err()
			}
		}

		return nil
	})

	// Store incoming messages in user inboxes
	errs.Go(func() error {
		for {
			request, err := stream.Recv()
			if err != nil {
				return err
			}

			recID := "1234"

			s.mutex.Lock()
			if _, ok := s.inbox[recID]; !ok {
				s.inbox[recID] = make(chan *pb.Message)
			}
			for _, message := range request.GetMessages() {
				s.inbox[recID] <- message
			}
			s.mutex.Unlock()
		}
	})

	return errs.Wait()
}
