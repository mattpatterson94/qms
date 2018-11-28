defmodule Qms.Spotify.Api.Token do
  use HTTPoison.Base

  @host "https://accounts.spotify.com/api/token"
  @expected_fields ~w(access_token refresh_token expires_in)

  def process_request_url(url) do
    @host <> url
  end

  def process_response_body(body) do
    IO.inspect body

    body
    |> Poison.decode!
    |> Map.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
