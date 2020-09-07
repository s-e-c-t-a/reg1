defmodule Reg1Web.ParrotControllerTest do
  use Reg1Web.ConnCase

  alias Reg1.Secta

  @create_attrs %{description: "some description", send_parrots: 42, title: "some title"}
  @update_attrs %{description: "some updated description", send_parrots: 43, title: "some updated title"}
  @invalid_attrs %{description: nil, send_parrots: nil, title: nil}

  def fixture(:parrot) do
    {:ok, parrot} = Secta.create_parrot(@create_attrs)
    parrot
  end

  describe "index" do
    test "lists all parrots", %{conn: conn} do
      conn = get(conn, Routes.parrot_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Parrots"
    end
  end

  describe "new parrot" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.parrot_path(conn, :new))
      assert html_response(conn, 200) =~ "New Parrot"
    end
  end

  describe "create parrot" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.parrot_path(conn, :create), parrot: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.parrot_path(conn, :show, id)

      conn = get(conn, Routes.parrot_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Parrot"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.parrot_path(conn, :create), parrot: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Parrot"
    end
  end

  describe "edit parrot" do
    setup [:create_parrot]

    test "renders form for editing chosen parrot", %{conn: conn, parrot: parrot} do
      conn = get(conn, Routes.parrot_path(conn, :edit, parrot))
      assert html_response(conn, 200) =~ "Edit Parrot"
    end
  end

  describe "update parrot" do
    setup [:create_parrot]

    test "redirects when data is valid", %{conn: conn, parrot: parrot} do
      conn = put(conn, Routes.parrot_path(conn, :update, parrot), parrot: @update_attrs)
      assert redirected_to(conn) == Routes.parrot_path(conn, :show, parrot)

      conn = get(conn, Routes.parrot_path(conn, :show, parrot))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, parrot: parrot} do
      conn = put(conn, Routes.parrot_path(conn, :update, parrot), parrot: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Parrot"
    end
  end

  describe "delete parrot" do
    setup [:create_parrot]

    test "deletes chosen parrot", %{conn: conn, parrot: parrot} do
      conn = delete(conn, Routes.parrot_path(conn, :delete, parrot))
      assert redirected_to(conn) == Routes.parrot_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.parrot_path(conn, :show, parrot))
      end
    end
  end

  defp create_parrot(_) do
    parrot = fixture(:parrot)
    {:ok, parrot: parrot}
  end
end
