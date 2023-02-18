package test

import (
	"fmt"
	"net/http"
	"os"
	"testing"
)

func TestUploadFile(t *testing.T) {
	URL := "https://wyd-app.s3.us-west-2.amazonaws.com/myFile.jpeg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2OV7PPDHUAZ64JHR%2F20230218%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230218T195139Z&X-Amz-Expires=300&X-Amz-SignedHeaders=host&x-id=PutObject&X-Amz-Signature=c1ac748898de3dcad8fac410575bf019dedbca7f32fd3262c3cd9452ad58c6d7"

	uploadFile, err := os.Open("/Users/trumanpurnell/Desktop/me.jpeg")
	if err != nil {
		fmt.Println(err)
	}

	info, err := uploadFile.Stat()

	if err != nil {
		fmt.Println(err)
	}

	putRequest, err := http.NewRequest("PUT", URL, uploadFile)

	if err != nil {
		fmt.Println(err)
	}
	putRequest.ContentLength = info.Size()

	http.DefaultClient.Do(putRequest)
}
