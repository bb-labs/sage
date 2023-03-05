package routes

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/i-r-l/slide/src/types"
	"go.mongodb.org/mongo-driver/mongo"
)

func HandleCreateUser(db *mongo.Client) func(*gin.Context) {
	return func(ctx *gin.Context) {
		logger := log.Default()

		var userCreateRequest types.UserCreateRequest
		ctx.BindJSON(&userCreateRequest)

		logger.Println(userCreateRequest)

		// filter := bson.D{{Key: "userId", Value: userLocation.User.Token.AccessToken}}
		// update := bson.D{{Key: "$set", Value: userLocation}}
		// options := options.Update().SetUpsert(true)

		// db.Database(os.Getenv("MONGO_DB_NAME")).Collection("users").UpdateOne(ctx, filter, update, options)

		// ctx.String(http.StatusOK, "Success, bro")
	}

}
