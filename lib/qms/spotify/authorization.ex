defmodule Qms.Spotify.Authorization do
  alias Qms.UriHelper

  @spotify_host "https://accounts.spotify.com/api/token"

  def by_code(user, code) do
    @spotify_host
    |> UriHelper.add_param("code", code)

    %{
      "access_token" => "asdjnjkasndjksankjsd",
      "refresh_token" => "12222asxcqsdasdsa",
      "expires_in" => Timex.now
    }
  end

  def by_refresh_token(user) do
    @spotify_host
      |> UriHelper.add_param("token", user.spotify_refresh_token)

    %{
      "access_token" => "asdjnjkasndjksankjsd",
      "refresh_token" => "12222asxcqsdasdsa",
      "expires_in" => Timex.now
    }
  end
end
