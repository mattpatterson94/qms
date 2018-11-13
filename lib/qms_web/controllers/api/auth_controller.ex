defmodule QmsWeb.Api.AuthController do
  use QmsWeb, :controller

  alias Qms.Repo
  alias Qms.User
  alias Qms.Spotify

  def create(conn, _params = %{"user_id" => user_id}) do
    user = find_user(user_id)

    case User.valid(user) do
      true  -> render_user_valid(conn)
      false -> set_user_temp_token(user)
                |> render_success(conn)
    end
  end

  def create(conn, _params) do
    render_error(conn)
  end

  # Private

  defp set_user_temp_token(user) do
    result = Ecto.Changeset.change(user, temp_auth_token: Ecto.UUID.generate)
              |> Repo.insert_or_update

    case result do
      {:ok, user} -> user
    end
  end

  defp render_success(user, conn) do
    spotify_url = Spotify.AuthorizeUrlGenerator.generate_url(user.temp_auth_token)
    render conn, "create.json", url: spotify_url, type: :success
  end

  defp render_user_valid(conn) do
    conn
      |> put_status(200)
      |> render("create.json", type: :exists)
  end

  defp render_error(conn) do
    conn
      |> put_status(400)
      |> render("create.json", type: :error)
  end

  defp find_user(id) do
    case Repo.get_by(User, slack_user_id: id) do
      nil  -> %Qms.User{slack_user_id: id}
      user -> user
    end
  end
end
