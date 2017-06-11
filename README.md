# Chat

## TODO

[x] List conversations for user
[x] Create conversation with another user
[x] List messages in conversation
[x] Create messages in conversation
[x] Read status
[ ] Announcements
[ ] Multiple participants

## Getting Started

Requires ruby 2.4 and postgres 9.6. Set the `DATABASE_ADDRESS`
`DATABASE_USERNAME` and `DATABASE_PASSWORD` environment variables to connect to
your database. Alternatively use the included docker compose configuration and
get started with `docker-compose up`.

Run `rails db:create db:migrate` then start the server. `rails s`

## Usage

Provide the `username` param to requests to "authenticate." A user is created if
one does not exist with that name.

```sh
curl 'http://chat.docker/api/conversations?username=xXjulianXx'
curl 'http://chat.docker/api/conversations?username=anth0ny'
curl -X POST 'http://chat.docker/api/conversations?username=xXjulianXx&to=anth0ny'
curl -X POST 'http://chat.docker/api/conversations/$CONVERSATION_ID/messages?username=xXjulianXx' \
  -H 'Content-Type: application/json' \
  --data '{ "message": { "body": "would you accept half your list price?" } }'
curl 'http://chat.docker/api/conversations/$CONVERSATION_ID/messages?username=anth0ny'
```

## Testing

`rspec`
