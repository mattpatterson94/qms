defmodule Qms.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:slack_user_id, :string)
    field(:spotify_refresh_token, :string)
    field(:spotify_access_token, :string)
    field(:spotify_token_expiration, :utc_datetime)
    field(:status, :integer)
    field(:temp_auth_token, :binary_id)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :slack_user_id,
      :spotify_refresh_token,
      :spotify_access_token,
      :spotify_token_expiration,
      :status,
      :temp_auth_token
    ])
    |> validate_required([:slack_user_id, :status])
  end

  def valid(user) do
    user.status == 1
  end

  def valid_access_token(user) do
    IO.puts("db expire")
    IO.inspect(user.spotify_token_expiration)

    IO.puts("current timestamp")
    IO.inspect(DateTime.now("Etc/UTC"))

    with({:ok, current_datetime} <- DateTime.now("Etc/UTC")) do
      current_datetime < user.spotify_token_expiration
    end
  end
end
