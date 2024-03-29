defmodule Reg1Web.ParrotController do
  use Reg1Web, :controller

  alias Reg1.Secta
  alias Reg1.Secta.Parrot

  def index(conn, _params) do
      xz = conn.assigns.current_user
      xzz = xz.id
           IO.puts "___________________"
           IO.inspect(xz.email)
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


  
      # xzz ''это текущий пользователь, хуй знает потому что как его было искать
      xz = conn.assigns.current_user
      xzz = xz.id

        recipient_user = String.to_integer(parrot_params["title"])
      #sender_user = parrot_params["user_id"]

           IO.puts "_________проверка сначала номера получателя, затем отправителя __________"
           IO.inspect(recipient_user)
           IO.inspect(xzz)
           IO.puts "___________________________________________________________"






       check_string_or_number_of_display = is_binary(Reg1Web.LayoutView.title(conn))
       
       display_parrots =  case check_string_or_number_of_display do
                               true -> 0
                               false -> Reg1Web.LayoutView.title(conn)
          #_ -> display_parrots = 0
       # else display_parrots = Reg1Web.LayoutView.title(conn)
                          end
      

      limit_parrots = display_parrots - check_send_parrots

      # проверка лимита
      case limit_parrots < -50 do
        
        false -> 
              
              #проверка отрицательного значения
              case check_send_parrots >= 1 do
                  true -> # parrot_params2 = Map.put_new(parrot_params, "user_id", xzz)
                          # find_title = Map.get(parrot_params2, to_string("title"))
                          # find_title2 = String.to_integer(find_title)
                          # presence_user = Secta.check_user_recipient(find_title2)
                           
                          presence_user = parrot_params
                                         |> Map.put_new("user_id", xzz)
                                         |> Map.get(to_string("title"))
                                         |> String.to_integer()
                                         |> Secta.check_user_recipient()





                                # !! тру или фолс,  true - если есть такой получатель в бд
                                case !!presence_user do
                                true -> 
                                          

                                          # проверка не отправляешь ли сам себе 
                                         # case recipient_user == xzz do
                                          #      true ->  xzz_string = Integer.to_string(xzz)
                                          #              parrots = Secta.list_parrots(xzz, xzz_string)
                                          #         conn
                                          #         |> put_flash(:info, "Ты че сам себе отправляешь?")
                                          #         |> redirect(to: Routes.parrot_path(conn, :index, parrots))
                                            

                                          #      false ->                                           
                                                      #parrot_params2
                                                      case Secta.create_parrot(Map.put_new(parrot_params, "user_id", xzz)) do
                                                           {:ok, parrot} ->
                                                                        conn
                                                                        |> put_flash(:info, "Попугаи улетели на юг!.")
                                                                        |> redirect(to: Routes.parrot_path(conn, :show, parrot))
                                           
                                                            {:error, %Ecto.Changeset{} = changeset} ->
                                                            render(conn, "new.html", changeset: changeset)
                                                      end


                                          #end


                                       
                                # false - значит нет получателя, и следовательно ничего не произойдет и укажет об этом
                                false ->
                                       # Есть проблема, если номер юзера указан с пробелом или как то нелепо, то будет ошибка
                                       xzz_string = Integer.to_string(xzz)
                                       parrots = Secta.list_parrots(xzz, xzz_string)
                                       conn
                                       |> put_flash(:info, "Нет такого сектанта")
                                       |> redirect(to: Routes.parrot_path(conn, :index, parrots))
                                end 

              #проверка отрицательного значения
                  false -> 
                          xzz_string = Integer.to_string(xzz)
                          parrots = Secta.list_parrots(xzz, xzz_string)
                          conn
                          |> put_flash(:info, "НЕ КРЕДИТУЕМ!")
                          |> redirect(to: Routes.parrot_path(conn, :index, parrots))
                          end

               
        # проверка лимита 
        true -> xzz_string = Integer.to_string(xzz)
                parrots = Secta.list_parrots(xzz, xzz_string)
                conn
                |> put_flash(:info, "Лимит исчерпан")
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
