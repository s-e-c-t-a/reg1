defmodule Reg1.Repo.Migrations.RenameTab do
  use Ecto.Migration

  def change do
     
     rename table("parrots"), :user_id, to: :to_user_id



  end
end
