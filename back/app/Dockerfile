FROM golang:latest

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .

CMD go build -o ./tmp/main ./src/main.go
