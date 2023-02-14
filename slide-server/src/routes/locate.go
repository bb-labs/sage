package routes

import (
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/i-r-l/slide/src/types"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func HandleLocation(db *mongo.Client) func(*gin.Context) {
	return func(ctx *gin.Context) {
		var userLocation types.LocationUpdateRequest

		ctx.BindJSON(&userLocation)

		filter := bson.D{{Key: "userId", Value: userLocation.User.Token.AccessToken}}
		update := bson.D{{Key: "$set", Value: userLocation}}
		options := options.Update().SetUpsert(true)

		db.Database(os.Getenv("MONGO_DB_NAME")).Collection("users").UpdateOne(ctx, filter, update, options)

		ctx.String(http.StatusOK, "Success, bro")
	}

}
