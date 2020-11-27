defmodule Reg1Web.ParrotController do
  use Reg1Web, :controller

  alias Reg1.Secta
  alias Reg1.Secta.Parrot

  def index(conn, _params) do
      xz = conn.assigns.current_user
      xzz = xz.id
           IO.puts "___________________"
           IO.inspect(xzz)
           IO.puts "___________________"
      xzz_string = Integer.to_string(xzz)
      parrots = Secta.list_parrots(xzz, xzz_string)
      render(conn, "index.html", parrots: parrots)
  end

  def new(conn, _params) do
    changeset = Secta.change_parrot(%Parrot{})
    render(conn, "new.html", changeset: changeset)
  end


  def create(conn, %{"parrot" => parrot_params}) do
      # %{
      # "description" => "ljljljljljlj",
      # "send_parrots" => "7",
      # "title" => "2",
      # "user_id" => 1
      # }

      #_____ПРОВЕРКА ОТРИЦАТЕЛЬНОГО ЗНАЧЕНИЯ
      check_send_parrots = String.to_integer(parrot_params["send_parrots"])
          # IO.puts "_________ПРОВЕРКА ОТРИЦАТЕЛЬНОГО ЗНАЧЕНИЯ__________"
          # IO.inspect(check_send_parrots)
          # IO.puts "________<<<=====>>>___________"


      xz = conn.assigns.current_user
      xzz = xz.id

      case check_send_parrots >= 1 do
        
           true -> parrot_params2 = Map.put_new(parrot_params, "user_id", xzz)
                   find_title = Map.get(parrot_params2, to_string("title"))
                   find_title2 = String.to_integer(find_title)
                   presence_user = Secta.check_user_recipient(find_title2)
             
                   # !! тру или фолс,  true - если есть такой получатель в бд
                   case !!presence_user do
                       true ->
                           case Secta.create_parrot(parrot_params2) do
                               {:ok, parrot} ->
                                    conn
                                    |> put_flash(:info, "Попугаи улетели на юг!.")
                                    |> redirect(to: Routes.parrot_path(conn, :show, parrot))
                               
                               {:error, %Ecto.Changeset{} = changeset} ->
                                    render(conn, "new.html", changeset: changeset)
                           end
                       # false - значит нет получателя, и следовательно ничего не произойдет и укажет об этом
                       false ->
                           # Есть проблема, если номер юзера указан с пробелом или как то нелепо, то будет ошибка
                           xzz_string = Integer.to_string(xzz)
                           parrots = Secta.list_parrots(xzz, xzz_string)
                           conn
                           |> put_flash(:info, "Нет такого сектанта")
                           |> redirect(to: Routes.parrot_path(conn, :index, parrots))
                   end 
           false -> 
                xzz_string = Integer.to_string(xzz)
                parrots = Secta.list_parrots(xzz, xzz_string)
                conn
                |> put_flash(:info, "НЕ КРЕДИТУЕМ!")
                |> redirect(to: Routes.parrot_path(conn, :index, parrots))
      end
  end


  def show(conn, %{"id" => id}) do
    parrot = Secta.get_parrot!(id)
    render(conn, "show.html", parrot: parrot)
  end

  def edit(conn, %{"id" => id}) do
    parrot = Secta.get_parrot!(id)
    changeset = Secta.change_parrot(parrot)
    render(conn, "edit.html", parrot: parrot, changeset: changeset)
  end

  def update(conn, %{"id" => id, "parrot" => parrot_params}) do
    parrot = Secta.get_parrot!(id)

    case Secta.update_parrot(parrot, parrot_params) do
      {:ok, parrot} ->
        conn
        |> put_flash(:info, "Parrot updated successfully.")
        |> redirect(to: Routes.parrot_path(conn, :show, parrot))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", parrot: parrot, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    parrot = Secta.get_parrot!(id)
    {:ok, _parrot} = Secta.delete_parrot(parrot)
    conn
    |> put_flash(:info, "Parrot deleted successfully.")
    |> redirect(to: Routes.parrot_path(conn, :index))
  end
end
