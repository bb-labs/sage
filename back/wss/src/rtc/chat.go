package rtc

import (
	"io"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"google.golang.org/protobuf/proto"

	sageproto "github.com/i-r-l/sage/back/wss/protos"
)

func HandleChat(hub *Hub) func(*gin.Context) {
	return func(ctx *gin.Context) {
		logger := log.Default()

		chatReq := &sageproto.ChatRequest{}
		buf, err := io.ReadAll(ctx.Request.Body)

		if err != nil {
			logger.Printf("err reading chat request: %v", err)
			return
		}

		err = proto.Unmarshal(buf, chatReq)

		if err != nil {
			logger.Printf("err unmarshalling chat request: %v", err)
			return
		}

		_, err = hub.Store(chatReq, true)

		if err != nil {
			logger.Printf("err storing chat request: %v", err)
			return
		}

		ctx.JSON(http.StatusOK, gin.H{"status": "OK"})
	}
}
