package routes

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
	sageproto "github.com/i-r-l/sage/back/wss/protos"
	"google.golang.org/protobuf/proto"
)

func HandleSession(upgrader websocket.Upgrader) func(*gin.Context) {
	return func(ctx *gin.Context) {
		// Logger
		logger := log.Default()

		// upgrade HTTP connection to WebSocket
		conn, err := upgrader.Upgrade(ctx.Writer, ctx.Request, nil)
		if err != nil {
			log.Println(err)
			return
		}
		defer conn.Close()

		for {
			_, msg, err := conn.ReadMessage()
			if err != nil {
				log.Println(err)
				return
			}

			// Unmarshal
			webRTCReq := sageproto.WebRTCSignalingRequest{}
			err = proto.Unmarshal(msg, &webRTCReq)

			if err != nil {
				log.Println(err)
				return
			}

			switch webRTCReq.Type {
			case *sageproto.WebRTCRequestType_ICE.Enum():
				logger.Printf("Received ice: %v\n", webRTCReq)
			case *sageproto.WebRTCRequestType_SDP.Enum():
				logger.Printf("Received sdp: %v\n", webRTCReq)
			}

			// Write back
			err = conn.WriteMessage(websocket.TextMessage, []byte("What a nice message, thank you!"))

			if err != nil {
				log.Println(err)
				return
			}
		}
	}
}
