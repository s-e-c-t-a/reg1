defmodule Reg1.Users.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :wallet, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:wallet, :user_id])
    |> validate_required([:wallet, :user_id])
  end
end
