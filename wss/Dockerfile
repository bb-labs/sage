FROM golang:latest

WORKDIR /sage-wss-service

COPY ./go.mod ./go.sum ./
RUN go mod download 
RUN go mod verify

COPY . .

EXPOSE 3001

RUN go build -o ./tmp/main .

CMD ./tmp/main
