defmodule Qms.Spotify.GetUserSong do
  alias Qms.Spotify.Api.Player

  def call(user) do
    Player.start

    headers = ["Authorization": "Bearer #{user.spotify_access_token}", "Content-Type": "Application/json"]

    case Player.get("/currently-playing", headers) do
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
