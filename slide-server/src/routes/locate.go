package routes

import (
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/mongo"
)

func HandleLocation(db *mongo.Client) func(*gin.Context) {
	return func(ctx *gin.Context) {
		var location interface{}

		ctx.BindJSON(&location)

		db.Database(os.Getenv("MONGO_DB_NAME")).Collection("users").InsertOne(ctx, location)

		ctx.String(http.StatusOK, "Success, bro")
	}

}
