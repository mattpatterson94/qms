defmodule QmsWeb.Api.SongController do
  use QmsWeb, :controller

  alias Qms.{
    Repo,
    User,
    Spotify
  }

  def create(conn, params = %{"user_id" => user_id}) do
    user = find_user(user_id)

    case User.valid(user) do
      true  -> get_current_song(user)
              |> render_song_playing(params["text"], conn)
      false -> render_user_unauthed(conn)
    end
  end

  def create(conn, _params) do
    render_error(conn)
  end

  # Private

  defp get_current_song(user) do
    Spotify.GetUserSong.call(user)
  end

  defp render_song_playing(song, text, conn) do
    IO.inspect song

    conn
      |> put_status(200)
      |> render("create.json", song: song, text: text, type: :success)
  end

  defp render_user_unauthed(conn) do
    conn
      |> put_status(200)
      |> render("create.json", type: :error)
  end

  defp render_error(conn) do
    conn
      |> put_status(200)
      |> render("create.json", type: :error)
  end

  defp find_user(id) do
    case Repo.get_by(User, slack_user_id: id) do
      nil  -> %Qms.User{slack_user_id: id}
      user -> user
    end
  end
end
