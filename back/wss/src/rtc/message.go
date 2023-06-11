package rtc

// Message is communication struct between Client and Hub
type Message struct {
	Client *Client
	Data   []byte
}
