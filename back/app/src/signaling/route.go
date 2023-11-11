package rtc

import (
	"io"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"google.golang.org/protobuf/proto"

	sageproto "github.com/bb-labs/sage/back/app/protos"
)

func HandleRoute(hub *Hub) func(*gin.Context) {
	return func(ctx *gin.Context) {
		logger := log.Default()

		routeReq := &sageproto.RouteRequest{}
		buf, err := io.ReadAll(ctx.Request.Body)

		if err != nil {
			logger.Printf("err reading route request: %v", err)
			return
		}

		err = proto.Unmarshal(buf, routeReq)

		if err != nil {
			logger.Printf("err unmarshalling route request: %v", err)
			return
		}

		_, err = hub.Store(routeReq)

		if err != nil {
			logger.Printf("err storing route request: %v", err)
			return
		}

		ctx.JSON(http.StatusOK, gin.H{"status": "OK"})
	}
}
