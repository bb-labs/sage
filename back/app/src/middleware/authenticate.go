package middleware

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/i-r-l/slide/src/auth"
)

func HandleAuth() gin.HandlerFunc {
	return func(ctx *gin.Context) {
		refreshToken := ctx.Query("refresh_token")
		identityToken := ctx.Query("identity_token")
		authorizationCode := ctx.Query("authorization_code")

		if authorizationCode != "" {
			refreshResponse, err := auth.RefreshToken(authorizationCode)

			if err != nil {
				ctx.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"error": err})
				return
			}

			ctx.Set("refresh_token", refreshResponse.RefreshToken)
			ctx.Set("identity_token", refreshResponse.IdToken)
			ctx.Next()

			return
		}

		idIsValid, err := auth.VerifyIdToken(identityToken)

		// Token is valid, move along
		if idIsValid {
			ctx.Next()
			return
		}

		// Maybe the token is expired, but they have a refresh token
		if refreshToken != "" {
			refreshResponse, err := auth.RefreshIdentity(refreshToken)

			if err != nil {
				ctx.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"error": err})
				return
			}

			ctx.Set("refresh_token", refreshResponse.RefreshToken)
			ctx.Set("identity_token", refreshResponse.IdToken)
			ctx.Next()
			return
		}

		// Token is invalid, sorry buddy
		if err != nil {
			ctx.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"error": err})
			return
		}
	}
}
