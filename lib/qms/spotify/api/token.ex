defmodule Qms.Spotify.Api.Token do
  use HTTPoison.Base

  @host "https://accounts.spotify.com/api"
  @allowed_fields ~w(access_token refresh_token expires_in error error_description)

  def process_request_url(url) do
    @host <> url
  end

  def process_response_body(body) do
    IO.inspect body

    body
    |> Poison.decode!
    |> Map.take(@allowed_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
