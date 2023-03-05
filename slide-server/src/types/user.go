package types

type Token struct {
	AccessToken  string `json:"access_token"`
	RefreshToken string `json:"refresh_token"`
}

type User struct {
	Location Location `json:"location"`
	Id       string   `json:"id"`
	Email    string   `json:"email"`
	VideoUrl string   `json:"video_url"`
	Name     string   `json:"name"`
	Rating   float64  `json:"rating"`
	Birthday int      `json:"age"`
	IsOnline bool     `json:"is_online"`
}

type UserCreateRequest struct {
	User User `json:"user"`
}
