defmodule Qms.Spotify.AuthTest do
  use Qms.DataCase

  alias Qms.Spotify.Auth

  setup do
    System.put_env("SPOTIFY_REDIRECT_URI", "http://example.com?token=%auth_token%")
    System.put_env("SPOTIFY_CLIENT_ID", "12345")
  end

  test "it generates a spotify auth url" do
    token = Ecto.UUID.generate
    auth_url = Auth.generate_url(token)
    expected_url = "https://accounts.spotify.com/authorize?response_type=code&client_id=12345&redirect_url=http://example.com?token=#{token}"

    assert auth_url == expected_url
  end
end
