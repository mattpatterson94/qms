defmodule Qms.Spotify.AuthorizeUrlGenerator do
  alias Qms.UriHelper

  @spotify_host "https://accounts.spotify.com/authorize"

  def generate(auth_token) do
    @spotify_host
      |> UriHelper.add_param("client_id", System.get_env("SPOTIFY_CLIENT_ID"), "?")
      |> UriHelper.add_param("redirect_uri", System.get_env("SPOTIFY_REDIRECT_URI"))
      |> UriHelper.add_param("response_type", "code")
      |> UriHelper.add_param("scope", "user-read-currently-playing")
      |> UriHelper.add_param("state", auth_token)
  end
end
