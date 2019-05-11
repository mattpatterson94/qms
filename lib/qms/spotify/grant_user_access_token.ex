defmodule Qms.Spotify.GrantUserAccessToken do
  alias Qms.Spotify.Api.Token

  def call(code) do
    Token.start

    client_id = System.get_env("SPOTIFY_CLIENT_ID")
    client_secret = System.get_env("SPOTIFY_CLIENT_SECRET")
    redirect_uri = System.get_env("SPOTIFY_REDIRECT_URI")
    grant_type = "authorization_code"

    auth = Base.encode64 "#{client_id}:#{client_secret}"

    token_body = [
      code: code,
      grant_type: grant_type,
      redirect_uri: redirect_uri
    ]

    case Token.post("/token", {:form, token_body}, [{"Authorization", "Basic #{auth}"}]) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        body
      {:ok, %HTTPoison.Response{body: body, status_code: 400}} ->
        IO.puts "There was an error"
        IO.inspect body
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
        reason
    end
  end
end
