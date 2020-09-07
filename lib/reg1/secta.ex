defmodule Reg1.Secta do
  @moduledoc """
  The Secta context.
  """

  import Ecto.Query, warn: false
  alias Reg1.Repo

  alias Reg1.Secta.Parrot

  @doc """
  Returns the list of parrots.

  ## Examples

      iex> list_parrots()
      [%Parrot{}, ...]

  """
  def list_parrots do
    Repo.all(Parrot)
  end

  @doc """
  Gets a single parrot.

  Raises `Ecto.NoResultsError` if the Parrot does not exist.

  ## Examples

      iex> get_parrot!(123)
      %Parrot{}

      iex> get_parrot!(456)
      ** (Ecto.NoResultsError)

  """
  def get_parrot!(id), do: Repo.get!(Parrot, id)

  @doc """
  Creates a parrot.

  ## Examples

      iex> create_parrot(%{field: value})
      {:ok, %Parrot{}}

      iex> create_parrot(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_parrot(attrs \\ %{}) do
    %Parrot{}
    |> Parrot.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a parrot.

  ## Examples

      iex> update_parrot(parrot, %{field: new_value})
      {:ok, %Parrot{}}

      iex> update_parrot(parrot, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_parrot(%Parrot{} = parrot, attrs) do
    parrot
    |> Parrot.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a parrot.

  ## Examples

      iex> delete_parrot(parrot)
      {:ok, %Parrot{}}

      iex> delete_parrot(parrot)
      {:error, %Ecto.Changeset{}}

  """
  def delete_parrot(%Parrot{} = parrot) do
    Repo.delete(parrot)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking parrot changes.

  ## Examples

      iex> change_parrot(parrot)
      %Ecto.Changeset{source: %Parrot{}}

  """
  def change_parrot(%Parrot{} = parrot) do
    Parrot.changeset(parrot, %{})
  end
end
