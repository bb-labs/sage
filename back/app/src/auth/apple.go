package auth

import (
	"crypto/x509"
	"encoding/pem"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"time"

	"github.com/lestrrat-go/jwx/v2/jwa"
	"github.com/lestrrat-go/jwx/v2/jws"
	"github.com/lestrrat-go/jwx/v2/jwt"
)

type Apple struct {
	Logger *log.Logger
}

func NewApple() *Apple {
	return &Apple{}
}

func (a *Apple) GenerateApnToken() (string, error) {
	keyId := os.Getenv("KEY_ID")
	keyPath := os.Getenv("KEY_PATH")
	teamId := os.Getenv("TEAM_ID")

	absPath, _ := filepath.Abs(keyPath)
	signingKey, _ := os.ReadFile(absPath)

	block, _ := pem.Decode(signingKey)
	if block == nil {
		return "", fmt.Errorf("err decoding key")
	}

	privKey, err := x509.ParsePKCS8PrivateKey(block.Bytes)
	if err != nil {
		return "", fmt.Errorf("err parsing key: %v", err)
	}

	token, err := jwt.NewBuilder().
		Issuer(teamId).
		IssuedAt(time.Now()).
		Build()
	if err != nil {
		return "", fmt.Errorf("err building key: %v", err)
	}

	headers := jws.NewHeaders()
	headers.Set("kid", keyId)
	signedToken, err := jwt.Sign(token, jwt.WithKey(jwa.ES256, privKey, jws.WithProtectedHeaders(headers)))
	if err != nil {
		return "", fmt.Errorf("err signing token: %v", err)
	}

	return string(signedToken), nil
}
