package user

import (
	"log"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)

func HandleFetchUsers(db *mongo.Client) func(*gin.Context) {
	return func(ctx *gin.Context) {
		results, err := db.Database(os.Getenv("MONGO_INITDB_DATABASE")).Collection(os.Getenv("DB_USERS_COLLECTION")).Find(ctx, bson.M{})

		if err != nil {
			log.Fatalln("err: ", err)
		}

		ctx.JSON(http.StatusOK, &results)
	}
}
