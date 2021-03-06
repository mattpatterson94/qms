defmodule Qms.Repo.Migrations.UpdateUsersTable2 do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :temp_auth_token, :uuid
      remove :spotify_token_expiration
      add :spotify_token_expiration, :utc_datetime
    end
  end

  def down do
    alter table(:users) do
      remove :spotify_token_expiration
      add :spotify_token_expiration, :string
      remove :temp_auth_token
    end
  end
end
