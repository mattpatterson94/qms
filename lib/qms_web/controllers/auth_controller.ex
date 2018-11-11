defmodule QmsWeb.AuthController do
  use QmsWeb, :controller

  alias Qms.Repo
  alias Qms.User
  alias Qms.Spotify

  def create(conn, _params = %{"user_id" => user_id}) do
    cond do
      # user_exists(user_id) -> render_user_exists(conn)
      true                 -> create_user(user_id)
                              |> render_success(conn)

    end
  end

  def create(conn, _params) do
    render_error(conn)
  end

  # Private

  defp create_user(user_id) do
    user = %Qms.User{slack_user_id: user_id, temp_auth_token: UUID.uuid1()}
    Qms.Repo.insert(user, on_conflict: :nothing)
    user
  end

  defp render_success(user, conn) do
    spotify_url = Spotify.Auth.generate_url(user.temp_auth_token)
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
end
