defmodule QmsWeb.AuthController do
  use QmsWeb, :controller

  def create(conn, _params) do
    render conn, "create.json", url: "http://example.com"
  end
end
