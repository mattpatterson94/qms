defmodule QmsWeb.Api.SongController do
  use QmsWeb, :controller

  def create(conn, _params) do
    response = Qms.Spotify.get()

    render conn, "show.json"
  end
end
