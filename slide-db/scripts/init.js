
db.createCollection('users');

db.runCommand({
  shardCollection: 'slide.users',
  key: {
    _id: 'hashed',
  },
});

// Seed users
db.users.batchInsert([
  {
    location: { type: "Point", coordinates: [-104.976990, 39.721515] },
    video_url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    token: { access: "123", refresh: "456" },
    rating: 95,
    is_online: false,
  },
  {
    location: { type: "Point", coordinates: [-104.981109, 39.721473] },
    video_url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    token: { access: "789", refresh: "1011" },
    rating: 95,
    is_online: false,
  },
  {
    location: { type: "Point", coordinates: [-104.960823, 39.721399] },
    video_url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
    token: { access: "1213", refresh: "1415" },
    rating: 23,
    is_online: false,
  },
  {
    location: { type: "Point", coordinates: [-105.067246, 39.760308] },
    video_url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
    token: { access: "1617", refresh: "1819" },
    rating: 44,
    is_online: false,
  },
  {
    location: { type: "Point", coordinates: [-105.171297, 39.748994] },
    video_url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    token: { access: "2021", refresh: "2223" },
    rating: 10,
    is_online: false,
  },
  {
    location: { type: "Point", coordinates: [-105.226292, 39.724374] },
    video_url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
    token: { access: "2425", refresh: "2627" },
    rating: 15,
    is_online: false,
  },
])
