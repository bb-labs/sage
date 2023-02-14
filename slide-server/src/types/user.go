package types

type Token struct {
	AccessToken  string `json:"access_token"`
	RefreshToken string `json:"refresh_token"`
}

type User struct {
	Location          Location `json:"location"`
	Token             Token    `json:"token"`
	VideoUrl          string   `json:"video_url"`
	IdentificationUrl string   `json:"id_url"`
	Name              string   `json:"name"`
	Rating            float64  `json:"rating"`
	Age               int      `json:"age"`
	IsOnline          bool     `json:"is_online"`
}
