package routes

import (
	"io"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/mongo"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"

	sageproto "github.com/i-r-l/sage/back/auth/protos"
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

		jsonBuf, _ := protojson.Marshal(&token)

		ctx.JSON(http.StatusOK, gin.H{"status": "YAY!"})
	}
}
