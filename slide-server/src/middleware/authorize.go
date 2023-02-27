package middleware

import (
	"io"
	"log"
	"net/http"
	"net/url"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/i-r-l/slide/src/utils"
)

func Authenticate() gin.HandlerFunc {
	return func(ctx *gin.Context) {
		logger := log.Default()

		secret, _ := utils.GenerateClientSecret()

		urlValues := url.Values{}
		urlValues.Set("client_id", "trumanpurnell.Slide")
		urlValues.Set("grant_type", "authorization_code")
		urlValues.Set("code", ctx.Query("code"))
		urlValues.Set("client_secret", secret)

		request, _ := http.NewRequest("POST", "https://appleid.apple.com/auth/token", strings.NewReader(urlValues.Encode()))
		request.Header.Add("content-type", "application/x-www-form-urlencoded")
		request.Header.Add("accept", "application/json")
		request.Header.Add("user-agent", "wyd-app")

		response, err := http.DefaultClient.Do(request)
		bodyBytes, _ := io.ReadAll(response.Body)

		logger.Println(string(bodyBytes), err)

		if err != nil {
			logger.Println("response err: ", err)
			ctx.Abort()
			ctx.JSON(http.StatusUnauthorized, gin.H{"error": "unauthorized"})
		}

		ctx.JSON(http.StatusAccepted, gin.H{"status": response.Status})
	}
}
