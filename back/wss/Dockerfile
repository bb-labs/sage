FROM golang:latest

WORKDIR /usr/src/wss

COPY go.mod go.sum ./
RUN go mod download && go mod verify
RUN go install github.com/cosmtrek/air@latest

COPY . .

CMD air -c .air.toml