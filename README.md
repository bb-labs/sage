# sage

Please read da code to start da work

# development

```
$ make up

$ grpcurl -plaintext -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c' -d '{ "user": { "id": "abc" } }' localhost:3000 Sage.CreateUser
{
  "user": {
    "id": "abc"
  }
}

$ psql -h localhost -p 5432 -U username sagedb
Password for user username: password
psql (16.2 (Homebrew))
Type "help" for help.

sagedb=# select * from users;
 id  | name | email | rating | gender | birthday | video_url | location | preferences
-----+------+-------+--------+--------+----------+-----------+----------+-------------
 abc |      |       |        |        |          |           |          |
(1 row)
```

# docs

`aws.pdf`
