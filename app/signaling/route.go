package signaling

import (
	"io"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"google.golang.org/protobuf/proto"

	sageproto "github.com/bb-labs/sage/protos"
)

func HandleRoute(hub *Hub) func(*gin.Context) {
	return func(ctx *gin.Context) {
		routeReq := &sageproto.RouteRequest{}
		buf, err := io.ReadAll(ctx.Request.Body)

		if err != nil {
			log.Printf("err reading route request: %v", err)
			return
		}

		err = proto.Unmarshal(buf, routeReq)

		if err != nil {
			log.Printf("err unmarshalling route request: %v", err)
			return
		}

		_, err = hub.Store(routeReq)

		if err != nil {
			log.Printf("err storing route request: %v", err)
			return
		}

		ctx.JSON(http.StatusOK, gin.H{"status": "OK"})
	}
}
