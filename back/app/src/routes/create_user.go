package routes

import (
	"io"
	"log"
	"net/http"
	"os"

	sageproto "github.com/i-r-l/sage/back/app/protos"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"google.golang.org/protobuf/proto"
)

func HandleCreateUser(db *mongo.Client) func(*gin.Context) {
	return func(ctx *gin.Context) {
		logger := log.Default()

		user := sageproto.User{}
		buf, err := io.ReadAll(ctx.Request.Body)

		if err != nil {
			logger.Fatalln(err)
		}

		if err := proto.Unmarshal(buf, &user); err != nil {
			logger.Fatalln(err)
		}

		update := bson.D{{Key: "$set", Value: &user}}
		db.Database(os.Getenv("MONGO_DB_NAME")).Collection("users").InsertOne(ctx, update)

		ctx.JSON(http.StatusOK, gin.H{"status": "OK"})
	}
}
