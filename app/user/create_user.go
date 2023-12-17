package user

import (
	"io"
	"log"
	"net/http"
	"net/url"
	"os"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"

	sageproto "github.com/bb-labs/sage/protos"
)

func HandleCreateUser(db *mongo.Client) func(*gin.Context) {
	return func(ctx *gin.Context) {
		// Write user to db
		user := sageproto.User{}
		buf, err := io.ReadAll(ctx.Request.Body)

		if err != nil {
			log.Fatalln("err: ", err)
		}

		if err := proto.Unmarshal(buf, &user); err != nil {
			log.Fatalln("err: ", err)
		}

		_, err = db.Database(os.Getenv("MONGO_INITDB_DATABASE")).Collection(os.Getenv("DB_USERS_COLLECTION")).InsertOne(ctx, bson.M{
			"_id":   user.Token.Id,
			"email": user.Email,
		})

		if err != nil {
			log.Fatalln("err: ", err)
		}

		// Generate refresh token
		resp, err := http.PostForm(os.Getenv("APPLE_TOKEN_URL"), url.Values{
			"client_id":     {os.Getenv("APPLE_BUNDLE_ID")},
			"client_secret": {os.Getenv("APPLE_CLIENT_SECRET")},
			"grant_type":    {"authorization_code"},
			"code":          {user.Token.AuthCode},
		})

		if err != nil {
			log.Fatalln("err: ", err)
		}

		token := sageproto.Token{}
		buf, err = io.ReadAll(resp.Body)

		if err != nil {
			log.Fatal(err)
		}

		if err := protojson.Unmarshal(buf, &token); err != nil {
			log.Fatalln("err: ", err)
		}

		ctx.ProtoBuf(http.StatusOK, &token)
	}
}
