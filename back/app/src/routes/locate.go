package routes

import (
	"github.com/gin-gonic/gin"
	"github.com/i-r-l/slide/src/types"
	"go.mongodb.org/mongo-driver/mongo"
)

func HandleLocation(db *mongo.Client) func(*gin.Context) {
	return func(ctx *gin.Context) {
		var userLocation types.LocationUpdateRequest

		ctx.BindJSON(&userLocation)

		// filter := bson.D{{Key: "userId", Value: userLocation.User.Id}}
		// update := bson.D{{Key: "$set", Value: userLocation}}
		// options := options.Update().SetUpsert(true)

		// db.Database(os.Getenv("MONGO_DB_NAME")).Collection("users").UpdateOne(ctx, filter, update, options)

		// ctx.String(http.StatusOK, "Success, bro")
	}

}
