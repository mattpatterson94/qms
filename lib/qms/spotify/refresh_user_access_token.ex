defmodule Qms.Spotify.RefreshUserAccessToken do
  alias Qms.Spotify.Api.Token

  def call(user) do
    Token.start()

    client_id = System.get_env("SPOTIFY_CLIENT_ID")
    client_secret = System.get_env("SPOTIFY_CLIENT_SECRET")

    auth = Base.encode64("#{client_id}:#{client_secret}")

    token_body = [
      grant_type: "refresh_token",
      refresh_token: user.spotify_refresh_token
    ]

    case Token.post("/token", {:form, token_body}, [{"Authorization", "Basic #{auth}"}]) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        body

      {:ok, %HTTPoison.Response{body: body, status_code: 400}} ->
        IO.puts("There was an error")
        IO.inspect(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
        reason
    end
  end
end
