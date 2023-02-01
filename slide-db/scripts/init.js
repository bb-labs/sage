
db.createCollection('users');
db.runCommand({
  shardCollection: 'slide.users',
  key: {
    _id: 'hashed',
  },
});
