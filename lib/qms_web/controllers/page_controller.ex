defmodule QmsWeb.PageController do
  use QmsWeb, :controller

  def index(conn, _params) do
    render conn, "index.json"
  end
end
