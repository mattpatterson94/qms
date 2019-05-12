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
      true  -> ensure_access_token_valid(user)
              |> get_current_song
              |> render_song_playing(params["text"], conn)
      false -> set_user_temp_token(user)
              |> render_user_authentication(conn)
    end
  end

  def create(conn, _params) do
    render_error(conn)
  end

  # Private

  defp ensure_access_token_valid(user) do
    case User.valid_access_token(user) do
      true -> user
      false -> refresh_user_access_token(user)
    end
  end

  defp refresh_user_access_token(user) do
    Spotify.RefreshUserAccessToken.call(user)
      |> save_user_token(user)
  end

  defp save_user_token(response, user) do
    with(
        {:ok, current_datetime} <- DateTime.now("Etc/UTC"),
        expiry <- DateTime.add(current_datetime, response[:expires_in], :second)
    ) do
      Ecto.Changeset.change(user,
        spotify_access_token: response[:access_token],
        spotify_token_expiration: expiry,
      )
      |> Repo.update!
    end
  end

  defp get_current_song(user) do
    Spotify.GetUserSong.call(user)
  end

  defp render_song_playing(song, text, conn) do
    IO.inspect song

    conn
      |> put_status(200)
      |> render("create.json", song: song, text: text, type: :success)
  end

  defp set_user_temp_token(user) do
    result = Ecto.Changeset.change(user, temp_auth_token: Ecto.UUID.generate)
              |> Repo.insert_or_update

    case result do
      {:ok, user} -> user
    end
  end

  defp render_user_authentication(user, conn) do
    spotify_url = Spotify.AuthorizeUrlGenerator.generate(user.temp_auth_token)
    render conn, "create.json", url: spotify_url, type: :authentication
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
