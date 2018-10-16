defmodule Qms.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :slack_user_id, :string
      add :spotify_refresh_token, :string
      add :spotify_access_token, :string
      add :spotify_token_expiration, :string
      add :status, :integer, default: 1

      timestamps()
    end

    create unique_index(:users, [:slack_user_id])
  end
end
