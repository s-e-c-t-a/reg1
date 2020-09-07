defmodule Reg1.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :copleted, :boolean, default: false
    field :discription, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:discription, :copleted])
    |> validate_required([:discription, :copleted])
  end
end
