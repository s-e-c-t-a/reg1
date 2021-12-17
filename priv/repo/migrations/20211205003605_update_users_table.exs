defmodule Reg1.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do

      alter table(:users) do
          add :nick, :string

      end

  end
end
