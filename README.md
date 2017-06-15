# Chat

## TODO

[x] List conversations for user
[x] Create conversation with another user
[x] List messages in conversation
[x] Create messages in conversation
[x] Read status
[ ] Announcements
    This is a feature I'd really like to see in the product. It's a little
    jarring to see messages auto-sent from buyer and seller when a sale is made.
    Good fit for single table inheritance, allowing automated messages from
    neither participant or from moderators.
[ ] Multiple participants
    The pieces are all there. Group chat is only a controller change away.
[ ] Paginate collection endpoints

Regret not choosing names "thread" and "member" instead of "conversation" and
"participation."
Payloads are minimal - without more endpoints, relies on client to keep some
state to denormalize things like participating users.
Many-to-many participants makes for more expensive queries in some places but
enables lots of features that would be difficult to implement without it. see:
read receipts and group chat. It's a good fit for the product in question, for a
more spastic chat app would need to consider backgrounding or caching in those
places.

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
