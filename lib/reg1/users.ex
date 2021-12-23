defmodule Reg1.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Reg1.Repo

 
  alias Reg1.Users.Score

  @doc """
  Returns the list of scores.

  ## Examples

      iex> list_scores()
      [%Score{}, ...]

  """
  def find_mail(parrot_title) do

   parrot_title2 = String.to_integer(parrot_title)

    IO.puts "_________ищу что за значение передаю__________"
          IO.inspect(parrot_title2)
          IO.inspect(parrot_title)
    IO.puts "______________хуй_____________________________________________"

   # ff_email =
   # from u in Reg1.Users.User,
   # where: u.user_id == ^parrot_title2
   # Repo.all(ff_email)


    
   # from(Users) |> select([:id, :name]) |> Repo.get!(parrot_title2)

    f_email = Repo.get!(Reg1.Users.User, parrot_title2, prefix: "public" )
    f_email.email
  end


  def list_scores do
    Repo.all(Score)
  end

  @doc """
  Gets a single score.

  Raises `Ecto.NoResultsError` if the Score does not exist.

  ## Examples

      iex> get_score!(123)
      %Score{}

      iex> get_score!(456)
      ** (Ecto.NoResultsError)

  """
  def get_score!(id), do: Repo.get!(Score, id)

  @doc """
  Creates a score.

  ## Examples

      iex> create_score(%{field: value})
      {:ok, %Score{}}

      iex> create_score(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_score(attrs \\ %{}) do
    %Score{}
    |> Score.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a score.

  ## Examples

      iex> update_score(score, %{field: new_value})
      {:ok, %Score{}}

      iex> update_score(score, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_score(%Score{} = score, attrs) do
    score
    |> Score.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a score.

  ## Examples

      iex> delete_score(score)
      {:ok, %Score{}}

      iex> delete_score(score)
      {:error, %Ecto.Changeset{}}

  """
  def delete_score(%Score{} = score) do
    Repo.delete(score)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking score changes.

  ## Examples

      iex> change_score(score)
      %Ecto.Changeset{source: %Score{}}

  """
  def change_score(%Score{} = score) do
    Score.changeset(score, %{})
  end
end
