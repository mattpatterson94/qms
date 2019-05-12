defmodule Qms.Spotify.Api.Player do
  use HTTPoison.Base

  @host "https://api.spotify.com/v1/me/player"
  @allowed_fields ~w(context timestamp progress_ms is_playing currently_playing_type actions item)

  def process_request_url(url) do
    @host <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Map.take(@allowed_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
