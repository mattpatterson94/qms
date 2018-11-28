defmodule Qms.Spotify.AuthorizeUrlGeneratorTest do
  use Qms.DataCase

  alias Qms.Spotify.AuthorizeUrlGenerator

  setup do
    System.put_env("SPOTIFY_REDIRECT_URI", "http://example.com")
    System.put_env("SPOTIFY_CLIENT_ID", "12345")
  end

  describe "auth/1" do
    test "it generates a spotify auth url" do
      token = Ecto.UUID.generate
      auth_url = AuthorizeUrlGenerator.generate(token)
      expected_url = "https://accounts.spotify.com/authorize?client_id=12345&redirect_uri=http://example.com&response_type=code&scope=user-read-currently-playing&state=#{token}"

      assert auth_url == expected_url
    end
  end
end
