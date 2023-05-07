package types

import "time"

type Match struct {
	User      User
	OtherUser User
	Location  Location
	CreatedAt time.Time
}

type Criteria struct {
	AgeMin    int
	AgeMax    int
	Proximity LocationProximity
}
