defmodule QmsWeb.SongController do
  use QmsWeb, :controller

  def index(conn, _params) do
    render conn, "show.json"
  end
end
