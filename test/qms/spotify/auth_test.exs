defmodule Qms.Spotify.AuthTest do
  use Qms.DataCase

  alias Qms.Spotify.Auth

  setup do
    Application.put_env(:qms, "SPOTIFY_REDIRECT_URI", "http://example.com")
    Application.put_env(:qms, "SPOTIFY_CLIENT_ID", "12345")
  end

  test "it generates a spotify auth url" do
    auth_url = Auth.generate_url
    expected_url = "https://accounts.spotify.com/authorize?response_type=code&client_id=12345&redirect_url=http://example.com"

    assert auth_url == expected_url
  end
end
