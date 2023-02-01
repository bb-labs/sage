package routes

import (
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type LocationRequest struct {
	UserId   string   `json:"userId"`
	Location Location `json:"location"`
}

type Location struct {
	LocationType string `json:"type"`
	Coordinates  []int  `json:"coordinates"`
}

func HandleLocation(db *mongo.Client) func(*gin.Context) {
	return func(ctx *gin.Context) {
		var userLocation LocationRequest

		ctx.BindJSON(&userLocation)

		filter := bson.D{{Key: "userId", Value: userLocation.UserId}}
		update := bson.D{{Key: "$set", Value: userLocation}}
		options := options.Update().SetUpsert(true)

		db.Database(os.Getenv("MONGO_DB_NAME")).Collection("users").UpdateOne(ctx, filter, update, options)

		ctx.String(http.StatusOK, "Success, bro")
	}

}
