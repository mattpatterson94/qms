defmodule Qms.Spotify.Auth do
  @spotify_host "https://accounts.spotify.com/authorize"

  def generate_url(auth_token) do
    @spotify_host
    |> with_param("client_id", System.get_env("SPOTIFY_CLIENT_ID"), "?")
    |> with_param("redirect_uri", System.get_env("SPOTIFY_REDIRECT_URI"))
    |> with_param("response_type", "code")
    |> with_param("scope", "user-read-currently-playing")
    |> with_param("state", auth_token)
  end

  defp with_param(host, param_name, param_value, concatenator \\ "&") do
    "#{host}#{concatenator}#{param_name}=#{param_value}"
  end
end
