package routes

import (
	"io"
	"log"

	"github.com/gin-gonic/gin"
	"github.com/golang/protobuf/proto"
	sageproto "github.com/i-r-l/sage/back/auth/protos"
	"go.mongodb.org/mongo-driver/mongo"
)

func HandleAuth(db *mongo.Client) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		logger := log.Default()

		token := sageproto.Token{}

		buf, err := io.ReadAll(ctx.Request.Body)
		if err != nil {
			logger.Println("err: ", err)
			return
		}

		if err := proto.Unmarshal(buf, &token); err != nil {
			logger.Println("err: ", err)
			return
		}

		logger.Println("Hey token!", token.DeviceToken)
	}
}
