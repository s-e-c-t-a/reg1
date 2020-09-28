defmodule Reg1Web.ParrotController do
  use Reg1Web, :controller

  alias Reg1.Secta
  alias Reg1.Secta.Parrot

  def index(conn, _params) do
          #user_id = "conn.assigns" |> Map.get(id, nil)
      ## user_id = conn.assigns
      xz = conn.assigns.current_user
      xzz = xz.id

           IO.puts "___________________"
           IO.inspect(xzz)
           IO.puts "___________________"

    parrots = Secta.list_parrots(xzz)
    render(conn, "index.html", parrots: parrots)
  end

  def new(conn, _params) do
    changeset = Secta.change_parrot(%Parrot{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"parrot" => parrot_params}) do
    xz = conn.assigns.current_user
      xzz = xz.id
      parrot_params2 = Map.put_new(parrot_params, "user_id", xzz)
       
IO.puts "________а теперь паррто парамс___________"
IO.inspect(parrot_params2)
IO.puts "___________________"
    case Secta.create_parrot(parrot_params2) do
      {:ok, parrot} ->
        conn
        |> put_flash(:info, "Parrot created successfully.")
        |> redirect(to: Routes.parrot_path(conn, :show, parrot))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
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
