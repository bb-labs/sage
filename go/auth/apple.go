package auth

import (
	"crypto/x509"
	"encoding/pem"
	"fmt"
	"os"
	"path/filepath"
	"time"

	"github.com/lestrrat-go/jwx/v2/jwa"
	"github.com/lestrrat-go/jwx/v2/jws"
	"github.com/lestrrat-go/jwx/v2/jwt"
)

func GenerateAppleClientSecret(keyId, keyPath, teamId, bundleId string) (string, error) {
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
		Expiration(time.Now().Add(24 * time.Hour * 180)).
		Audience([]string{"https://appleid.apple.com"}).
		Subject(bundleId).
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
