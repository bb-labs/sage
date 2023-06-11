package test_test

import (
	"bytes"
	"io/ioutil"
	"net/http"
	"testing"
	"time"

	"github.com/golang/protobuf/proto"

	sageproto "github.com/i-r-l/sage/back/wss/protos"
)

func TestSendChatRequest(t *testing.T) {
	// Create Users
	john := &sageproto.User{Id: "4fe602ce24720c0da87c8d33a638d47669f69fb74d1b7e9b54f44382adf74b17"}
	jane := &sageproto.User{Id: "387afdfe09c45b8ce033337e46ca94e26c2afe2c1d94e4b820b521a58802be6a"}

	// Create a ChatRequest message
	chatRequest := &sageproto.ChatRequest{User: john, OtherUser: jane}

	// Convert the ChatRequest message to bytes
	protoData, err := proto.Marshal(chatRequest)
	if err != nil {
		t.Fatalf("Error marshaling protobuf: %v", err)
	}

	// Create an HTTP client using the mock server URL
	client := &http.Client{
		Timeout: 5 * time.Second,
	}

	// Send the HTTP request to the mock server
	resp, err := client.Post("http://localhost:4000/chat", "application/x-protobuf", bytes.NewReader(protoData))
	if err != nil {
		t.Fatalf("Error sending request: %v", err)
	}
	defer resp.Body.Close()

	// Read the response body
	_, err = ioutil.ReadAll(resp.Body)
	if err != nil {
		t.Fatalf("Error reading response: %v", err)
	}

	// Verify the response status code and body
	if resp.StatusCode != http.StatusOK {
		t.Errorf("Unexpected response status code: got %d, want %d", resp.StatusCode, http.StatusOK)
	}
}
