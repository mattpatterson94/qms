defmodule QmsWeb.SongController do
  use QmsWeb, :controller

  def show(conn, _params) do
    render conn, "show.json"
  end
end
