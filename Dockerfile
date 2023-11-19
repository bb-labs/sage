FROM golang:latest AS base

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY src .

RUN go build -o ./tmp/main ./src/main.go

EXPOSE 3000

CMD ./tmp/main

