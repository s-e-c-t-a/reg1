defmodule Reg1.Repo.Migrations.RenGen do
  use Ecto.Migration

  def change do

  	rename table("parrots"), :to_user_id, to: :user_id

  end
end
