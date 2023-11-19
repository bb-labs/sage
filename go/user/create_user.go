package user

import (
	"io"
	"log"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"google.golang.org/protobuf/proto"

	sageproto "github.com/bb-labs/sage/protos"
)

func HandleCreateUser(db *mongo.Client) func(*gin.Context) {
	return func(ctx *gin.Context) {
		user := sageproto.User{}
		buf, err := io.ReadAll(ctx.Request.Body)

		if err != nil {
			log.Fatalln(err)
		}

		if err := proto.Unmarshal(buf, &user); err != nil {
			log.Fatalln(err)
		}

		update := bson.D{{Key: "$set", Value: &user}}
		db.Database(os.Getenv("MONGO_INITDB_DATABASE")).Collection("DB_USERS_COLLECTION").InsertOne(ctx, update)

		ctx.JSON(http.StatusOK, gin.H{"status": "OK"})
	}
}
