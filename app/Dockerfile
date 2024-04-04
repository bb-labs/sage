FROM golang:latest

WORKDIR /sage-app

COPY ./go.mod ./go.sum ./
RUN go mod download 
RUN go mod verify

COPY . .

EXPOSE 3000

RUN go build -o ./tmp/main .

CMD ./tmp/main
