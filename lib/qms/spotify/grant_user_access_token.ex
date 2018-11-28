defmodule Qms.Spotify.GrantUserAccessToken do
  alias Qms.Spotify.Api.Token

  def call(code) do
    Token.start

    client_id = System.get_env("SPOTIFY_CLIENT_ID")
    client_secret = System.get_env("SPOTIFY_CLIENT_SECRET")

    auth = Base.encode64 "#{client_id}:#{client_secret}"

    case Token.post("/", Poison.encode(%{code: code}), [{"Authorization", "Basic #{auth}"}, {"Content-Type", "application/x-www-form-urlencoded"}]) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        IO.puts body
        body
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
        reason
    end
  end
end
