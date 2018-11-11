defmodule Qms.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :slack_user_id, :string
    field :spotify_refresh_token, :string
    field :spotify_access_token, :string
    field :spotify_token_expiration, :utc_datetime
    field :status, :integer
    field :temp_auth_token, :binary_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:slack_user_id, :spotify_refresh_token, :spotify_access_token, :spotify_token_expiration, :status, :temp_auth_token])
    |> validate_required([:slack_user_id, :status])
    |> validate_inclusion(:status, 0..1)
  end
end
