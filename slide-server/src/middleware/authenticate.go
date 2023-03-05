package middleware

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/i-r-l/slide/src/auth"
)

func Authenticate() gin.HandlerFunc {
	return func(ctx *gin.Context) {
		logger := log.Default()

		// refreshToken := ctx.Query("refresh_token")
		// identityToken := ctx.Query("identity_token")
		authorizationCode := ctx.Query("authorization_code")

		refreshResponse, _ := auth.RefreshToken(authorizationCode)

		logger.Println("refreshResponse.IdToken: ", refreshResponse.IdToken)
		logger.Println("refreshResponse.RefreshToken: ", refreshResponse.RefreshToken)

		// idIsValid, _ := auth.VerifyIdToken(identityToken)

		// // Token is valid, move along
		// if idIsValid {
		// 	ctx.Next()
		// 	return
		// }

		// // Maybe the token is expired, but they have a refresh token
		// if refreshToken != "" {
		// 	refreshResponse, err := auth.RefreshToken(authorizationCode)

		// 	if err != nil {
		// 		logger.Println("refresh response err: ", err)
		// 		ctx.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"error": err})
		// 		return
		// 	}

		// 	ctx.Set("refresh", refreshResponse)
		// 	ctx.Next()
		// 	return
		// }

	}
}
