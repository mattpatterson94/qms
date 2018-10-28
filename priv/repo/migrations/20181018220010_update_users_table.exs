defmodule Qms.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :status, :integer, default: 0
    end
  end
end
