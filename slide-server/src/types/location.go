package types

type LocationUpdateRequest struct {
	Location Location `json:"location"`
}

type LocationProximity int

const (
	Building     LocationProximity = iota
	Neighborhood                   = iota
	City                           = iota
)

type Location struct {
	LocationType string `json:"type"`
	Coordinates  []int  `json:"coordinates"`
}
