defmodule QmsWeb.AuthController do
  use QmsWeb, :controller

  alias Qms.Spotify

  def create(conn, _params) do
    spotify_url = Spotify.Auth.generate_url()

    render conn, "create.json", url: spotify_url
  end
end
