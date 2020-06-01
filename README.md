# Githooks

This project is built to receive webhooks from an online version control system,
store them, and subsequently update a ticketing system.

Currently the online versioning vendor used is GitHub.
As a mock ticketing system webhook.site has been used.

To initialize the application:

- Clone the repository using ```git clone```.
- Run ```bundle exec bundle install``` to install necesarry depencies.
- Run ```bundle exec rails db:setup && rails db:migrate``` to setup and configure a Database.
- Run ```bundle exec rspec ``` to run the test suite
- Run ```bundle exec rubocop``` to run the ruby linter.

Please make sure to also create a .env file and store a ```webhook.site``` url under the key ```WEBHOOK_URL```
