defmodule QmsWeb.AuthController do
  use QmsWeb, :controller

  alias Qms.Repo
  alias Qms.User
  alias Qms.Spotify

  def create(conn, params) do
    if valid_params(params) do
      if user_exists(params["user_id"]) do
        render_user_exists(conn)
      else
        render_success(conn)
      end
    else
      render_error(conn)
    end
  end

  defp render_success(conn) do
    spotify_url = Spotify.Auth.generate_url()
    render conn, "create.json", url: spotify_url, type: :success
  end

  defp render_user_exists(conn) do
    conn
      |> put_status(200)
      |> render("create.json", type: :exists)
  end

  defp render_error(conn) do
    conn
      |> put_status(400)
      |> render("create.json", type: :error)
  end

  defp user_exists(id) do
    Repo.get_by(User, slack_user_id: id)
  end

  defp valid_params(params) do
    "user_id" in Map.keys(params)
  end
end
