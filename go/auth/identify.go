package auth

import (
	"io"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/mongo"
	"google.golang.org/protobuf/proto"

	sageproto "github.com/bb-labs/sage/protos"
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

		ctx.JSON(http.StatusOK, gin.H{"status": "YAY!"})
	}
}
