package utils

import (
	"crypto/x509"
	"encoding/pem"
	"errors"
	"io/ioutil"
	"net/http"
	"os"
	"path/filepath"
	"time"

	"github.com/lestrrat-go/jwx/v2/jwa"
	"github.com/lestrrat-go/jwx/v2/jwk"
	"github.com/lestrrat-go/jwx/v2/jws"
	"github.com/lestrrat-go/jwx/v2/jwt"
)

func VerifyIdToken(token string) (bool, error) {
	// Get Apple public key set
	resp, err := http.Get("https://appleid.apple.com/auth/keys")

	if err != nil {
		return false, err
	}

	applePublicKeys, _ := ioutil.ReadAll(resp.Body)
	applePublicKeySet, err := jwk.ParseString(string(applePublicKeys))

	if err != nil {
		return false, err
	}

	// Parse token to figure out which key id to use
	tokenMessage, err := jws.Parse([]byte(token))

	if err != nil {
		return false, err
	}

	keyId := tokenMessage.Signatures()[0].ProtectedHeaders().KeyID()

	// Get Apple public key
	applePublicKey, foundKey := applePublicKeySet.LookupKeyID(keyId)

	if !foundKey {
		return false, errors.New("missing key in key set")
	}

	// Parse the id token w/ apple's public key
	verifiedToken, err := jwt.Parse([]byte(token), jwt.WithKey(jwa.RS256, applePublicKey))

	if err != nil {
		return false, err
	}

	// Verify the token has not been tampered with
	if verifiedToken.Audience()[0] != os.Getenv("CLIENT_ID") {
		return false, nil
	}

	if verifiedToken.Issuer() != "https://appleid.apple.com" {
		return false, nil
	}

	if time.Now().After(verifiedToken.Expiration()) {
		return false, nil
	}

	return true, nil
}

func GenerateClientSecret() (string, error) {
	keyId := os.Getenv("KEY_ID")
	teamId := os.Getenv("TEAM_ID")
	clientId := os.Getenv("CLIENT_ID")
	signingKeyPath := os.Getenv("SIGNING_KEY_PATH")

	absPath, _ := filepath.Abs(signingKeyPath)
	signingKey, _ := os.ReadFile(absPath)

	block, _ := pem.Decode(signingKey)

	if block == nil {
		return "", errors.New("empty block after decoding")
	}

	privKey, err := x509.ParsePKCS8PrivateKey(block.Bytes)
	if err != nil {
		return "", err
	}

	token, err := jwt.NewBuilder().
		Issuer(teamId).
		IssuedAt(time.Now()).
		Expiration(time.Now().Add(time.Hour * 24 * 180)).
		Subject(clientId).
		Audience([]string{"https://appleid.apple.com"}).
		Build()

	if err != nil {
		return "", err
	}

	token.JwtID()

	headers := jws.NewHeaders()
	headers.Set("kid", keyId)

	signedToken, err := jwt.Sign(token, jwt.WithKey(jwa.ES256, privKey, jws.WithProtectedHeaders(headers)))

	if err != nil {
		return "", err
	}

	return string(signedToken), nil
}
