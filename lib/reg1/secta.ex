defmodule Reg1.Secta do
  @moduledoc """
  The Secta context.
  """

  import Ecto.Query, warn: false

  #из ecto.transaction
  import Ecto.Changeset, only: [change: 2]

  alias Reg1.Repo

  alias Reg1.Secta.Parrot
  alias Reg1.Users.User
  alias Reg1.Users.Score

  @doc """
  Returns the list of parrots.

  ## Examples

      iex> list_parrots()
      [%Parrot{}, ...]

  """
  # Входящие и исходящие
    def list_parrots(xzz, xzz_string) do

    pre_query =
    from p in Parrot,
    where: p.user_id == ^xzz or p.title == ^xzz_string
    Repo.all(pre_query)
    
  end


  def check_user_recipient(find_title2) do

    query = 
    from p in Parrot,
    where: p.user_id == ^find_title2
    pre_user = Repo.exists?(query)
       IO.puts "________query___________"
       IO.inspect(pre_user)
       IO.puts "________________________"
       pre_user
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

  # создание записи, расчета и последующей записи в Score :wallet
  def create_parrot(attrs \\ %{}) do
          
      # беру инфу про id пользователя записи в Score wallet:  Reg1.Repo.get_by(Reg1.Secta.Parrot, user_id: 1)
        # если у него нет записи, то создаю и пишу в wallet 0
      who_score_id = Reg1.Repo.get_by(Reg1.Users.Score, user_id: attrs["user_id"])
           case who_score_id do
              nil -> attrs2 = %{user_id: attrs["user_id"], wallet: 0}
             
                     %Score{}
                    |> Score.changeset(attrs2)
                    |> Repo.insert()
     
               _ -> who_score_id   
           end


      # беру инфу про id пользователя записи в Score wallet:  Reg1.Repo.get_by(Reg1.Secta.Parrot, user_id: 1)
        # если у него нет записи, то создаю и пишу в wallet 0
      whom_score_id = Reg1.Repo.get_by(Reg1.Users.Score, user_id: String.to_integer(attrs["title"]))
           case whom_score_id do
               nil -> attrs3 = %{user_id: attrs["title"], wallet: 0}
     
                    %Score{}
                    |> Score.changeset(attrs3)
                    |> Repo.insert()
     
               _ -> whom_score_id 
      end

      # для успешной транзакции обновляю значения про id пользователей в новой переменной
      who_score_id2 = Reg1.Repo.get_by(Reg1.Users.Score, user_id: attrs["user_id"])
      whom_score_id2 = Reg1.Repo.get_by(Reg1.Users.Score, user_id: String.to_integer(attrs["title"]))



         IO.puts "_________attrs in create_parrot__________"
           IO.inspect(attrs)
           IO.puts "________<<<>>>___________"

      # цифра того кто отылает    
      score_of_who = get_who_score(attrs)
           IO.puts "_________score_of_who__________"
           IO.inspect(score_of_who)
           IO.puts "________<<<||||>>>___________"

      # цифра того кому отсылают
      score_of_whom = get_whom_score(attrs)
           IO.puts "_________score_of_whom__________"
           IO.inspect(score_of_whom)


           IO.puts "________<<<||score_of_whom.wallet||>>>___________"
           IO.inspect(score_of_whom)
           IO.puts "________<<<||||>>>___________"


           IO.puts "________<<<||String.to_integer(attrs[send_parrots])||>>>___________"
           IO.inspect(String.to_integer(attrs["send_parrots"]))
           IO.puts "________<<<-->>>___________"
           

#проверка записи в score, если нет, то присваевается 0, если есть то запись в переменную wallet_who
# case wallet_who = Repo.get_by(Score, user_id: score_of_who) do
#   nil ->  0
#   _ -> Repo.get_by(Score, user_id: score_of_who)
# end          
 
#проверка записи в score, если нет, то присваевается 0, если есть то запись в переменную wallet_who
# case wallet_whom = Repo.get_by(Score, user_id: score_of_whom) do
#  nil -> 0
#   _ -> Repo.get_by(Score, user_id: score_of_whom)
# end          
 
          
           # _________attrs in create_parrot__________
           # %{"description" => "jf", "send_parrots" => "1", "title" => "2", "user_id" => 1}
           # ________<<<>>>___________


           # записываю в таблицу score значения
           

            Repo.transaction(fn ->
  Repo.update!(change(who_score_id2, wallet: score_of_who.wallet - String.to_integer(attrs["send_parrots"])))
  Repo.update!(change(whom_score_id2, wallet: score_of_whom.wallet + String.to_integer(attrs["send_parrots"])))

# MyRepo.transaction(fn ->
#  MyRepo.update!(change(alice, balance: alice.balance - 10))
#  MyRepo.update!(change(bob, balance: bob.balance + 10))
# end)

 # Repo.update!(change(wallet_who, wallet: wallet_who.wallet - String.to_integer(attrs["send_parrots"])))
 # Repo.update!(change(wallet_whom, wallet: wallet_whom.wallet + String.to_integer(attrs["send_parrots"])))
end)

# When passing a function of arity 1, it receives the repository itself
# Score.transaction(fn repo -> 
#  repo.insert!(%Score{})
# end)

# Roll back a transaction explicitly
# Score.transaction(fn ->
#  s = Score.insert!(%Score{})
#  if not Editor.post_allowed?(s) do
#    Score.rollback(:posting_not_allowed)
#  end
# end)

# With Ecto.Multi
# Ecto.Multi.new()
# |> Ecto.Multi.insert(:wallet, %Score{})
# |> Score.transaction

  #         score_transaction(attrs)
    %Parrot{}
    |> Parrot.changeset(attrs)
    |> Repo.insert()
  end


  # %{
  # "description" => "ljljljljljlj",
  # "send_parrots" => "7",
  # "title" => "2",
  # "user_id" => 1
  # }

 # цифра из кошелька того кто отсылает
  defp get_who_score(attrs) do
      who_send = attrs["user_id"]
   #   whom_send = String.to_integer(attrs["title"])
     
      query =
      from s in Score,
      where: s.user_id == ^who_send # or s.title == ^whom_send
      check_repo1 = Repo.all(query)
           IO.puts "_________проверка количества попугаев у отправителя__________"
           IO.inspect(check_repo1)
           IO.puts "________<<<|>>>___________"
          case check_repo1 do
            [] -> check_repo1 = [0]
            _ -> check_repo1
                 [check_repo1_list | _ ] = check_repo1 
                check_repo1_list
          end
  end


  # цифра из кошелька того кому отсылают
  defp get_whom_score(attrs) do
   #   who_send = attrs["user_id"]
      whom_send = String.to_integer(attrs["title"])
     
      query =
      from s in Score,
      where: s.user_id == ^whom_send
      check_repo2 = Repo.all(query)
           IO.puts "_________проверка количества попугаев у получателя__________"
           IO.inspect(check_repo2)
           IO.puts "________<<<||>>>___________"
           
            case check_repo2 do
            [] -> check_repo2 = [0]
            _ -> check_repo2
                 [check_repo2_list] = check_repo2 
                 check_repo2_list
          end
  end


  #defp score_transaction(attrs) do
  #  nil
  #end 


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
