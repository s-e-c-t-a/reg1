defmodule Reg1.Repo.Migrations.CreateParrots do
  use Ecto.Migration

  def change do
    create table(:parrots) do
      add :title, :string
      add :description, :text
      add :send_parrots, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:parrots, [:user_id])
  end
end
