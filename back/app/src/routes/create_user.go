package routes

import (
	"log"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/i-r-l/sage/back/app/protos/sageproto"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)

func HandleCreateUser(db *mongo.Client) func(*gin.Context) {
	return func(ctx *gin.Context) {
		logger := log.Default()

		user := sageproto.User{}

		var userCreateRequest types.UserCreateRequest
		ctx.BindJSON(&userCreateRequest)

		update := bson.D{{Key: "$set", Value: userCreateRequest.User}}
		db.Database(os.Getenv("MONGO_DB_NAME")).Collection("users").InsertOne(ctx, update)

		refresh_token, _ := ctx.Get("refresh_token")
		identity_token, _ := ctx.Get("identity_token")

		logger.Println("refresh_token: ", refresh_token)
		logger.Println("identity_token: ", identity_token)

		ctx.JSON(http.StatusOK, gin.H{
			"identity_token": identity_token,
			"refresh_token":  refresh_token,
		})
	}

}
