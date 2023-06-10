
db.createCollection('users');

// Seed users
const users = [
  {
    location: { type: "Point", coordinates: [-104.976990, 39.721515] },
    video_url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    rating: 95,
    is_online: false,
  },
  {
    location: { type: "Point", coordinates: [-104.981109, 39.721473] },
    video_url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    rating: 95,
    is_online: false,
  },
  {
    location: { type: "Point", coordinates: [-104.960823, 39.721399] },
    video_url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
    rating: 23,
    is_online: false,
  },
  {
    location: { type: "Point", coordinates: [-105.067246, 39.760308] },
    video_url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
    rating: 44,
    is_online: false,
  },
  {
    location: { type: "Point", coordinates: [-105.171297, 39.748994] },
    video_url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    rating: 10,
    is_online: false,
  },
  {
    location: { type: "Point", coordinates: [-105.226292, 39.724374] },
    video_url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
    rating: 15,
    is_online: false,
  },
]

users.forEach(user => db.users.insert(user))