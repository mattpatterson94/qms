defmodule QmsWeb.Webhook.AuthController do
  use QmsWeb, :controller

  alias Qms.{
    Repo,
    User,
    Spotify
  }

  def index(conn, _params = %{"code" => code, "state" => state}) do
    user = find_user_by_state(state)

    case user do
      user  -> authenticate_user(user, code)
                |> save_user_tokens(user)
                |> render_user_authenticated(conn)
      nil -> render_user_not_found(conn)
    end
  end

  def index(conn, _params) do
    render_user_not_found(conn)
  end

  # Private

  defp render_user_authenticated(user, conn) do
    conn
      |> render("index.html", type: :success)
  end

  defp save_user_tokens(response, user) do
    Ecto.Changeset.change(user,
      spotify_access_token: response["access_token"],
      spotify_refresh_token: response["refresh_token"],
      spotify_token_expiration: response["expires_in"]
    )
      |> IO.inspect
      |> Repo.update
  end

  defp authenticate_user(user, code) do
    Spotify.Authorization.by_code(user, code)
  end

  defp render_user_not_found(conn) do
    conn
      |> put_status(400)
      |> render("index.html", type: :not_found)
  end

  defp find_user_by_state(state) do
    Repo.get_by(User, temp_auth_token: state)
  end
end
