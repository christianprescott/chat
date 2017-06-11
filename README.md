# Chat

## TODO

[x] List conversations for user
[ ] Create conversation with another user
[ ] List messages in conversation
[ ] Create messages in conversation
[ ] Read status
[ ] Announcements
[ ] Multiple participants

## Getting Started

Requires ruby 2.4 and postgres 9.6. Set the `DATABASE_ADDRESS`
`DATABASE_USERNAME` and `DATABASE_PASSWORD` environment variables to connect to
your database. Alternatively use the included docker compose configuration and
get started with `docker-compose up`.

Run `rails db:create db:migrate` then start the server. `rails s`

## Testing

`rspec`
