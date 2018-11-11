# Qms (Quote My Song)

* [https://quote-my-song.herokuapp.com/](https://quote-my-song.herokuapp.com/)


#### Development


##### Setup
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Install [direnv](https://direnv.net/) via brew. `brew install direnv`
  * Copy .envrc.example to .envrc

##### Local Server
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


#### Testing
* Run `mix test` to run Exunit tests.
* When branch is pushed, codeship automatically runs the test suite.


#### Deployment

* When pushed to master, github sends hook to heroku and deploys.