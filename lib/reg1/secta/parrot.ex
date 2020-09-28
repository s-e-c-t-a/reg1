defmodule Reg1.Secta.Parrot do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parrots" do
    field :description, :string
    field :send_parrots, :integer
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(parrot, attrs) do
    parrot
    |> cast(attrs, [:title, :description, :send_parrots, :user_id])
    |> validate_required([:title, :description, :send_parrots])
  end
end
