defmodule QmsWeb.AuthController do
  use QmsWeb, :controller
  alias Qms.{Repo, User}

  def create(conn, params) do
    # render conn, "show.json"
    # spotify_url = "https://accounts.spotify.com/authorize"
    # redirect_uri = "http://localhost:4000/auth/update"
    # response_type = "code"
    # client_id = "1234"

    # User.registration_changeset(%User{}, params) |> Repo.insert()

    # redirect conn, external: "#{spotify_url}?response_type=#{response_type}&client_id=#{client_id}&redirect_uri=#{redirect_uri}"
    # :httpc.request('https://hooks.slack.com/commands/T19SES5DK/441835809616/eQo0f3m9tR2P6dKK3Bz3EHl5')

    render conn, "update.json"
  end

  # token=gIkuvaNzQIHg97ATvDxqgjtO
  # &team_id=T0001
  # &team_domain=example
  # &enterprise_id=E0001
  # &enterprise_name=Globular%20Construct%20Inc
  # &channel_id=C2147483705
  # &channel_name=test
  # &user_id=U2147483697
  # &user_name=Steve
  # &command=/weather
  # &text=94070
  # &response_url=https://hooks.slack.com/commands/1234/5678
  # &trigger_id=13345224609.738474920.8088930838d88f008e0

  def update(conn, _params) do
    render conn, "update.json"
  end
end
