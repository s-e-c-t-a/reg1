defmodule Reg1.SectaTest do
  use Reg1.DataCase

  alias Reg1.Secta

  describe "parrots" do
    alias Reg1.Secta.Parrot

    @valid_attrs %{description: "some description", send_parrots: 42, title: "some title"}
    @update_attrs %{description: "some updated description", send_parrots: 43, title: "some updated title"}
    @invalid_attrs %{description: nil, send_parrots: nil, title: nil}

    def parrot_fixture(attrs \\ %{}) do
      {:ok, parrot} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Secta.create_parrot()

      parrot
    end

    test "list_parrots/0 returns all parrots" do
      parrot = parrot_fixture()
      assert Secta.list_parrots() == [parrot]
    end

    test "get_parrot!/1 returns the parrot with given id" do
      parrot = parrot_fixture()
      assert Secta.get_parrot!(parrot.id) == parrot
    end

    test "create_parrot/1 with valid data creates a parrot" do
      assert {:ok, %Parrot{} = parrot} = Secta.create_parrot(@valid_attrs)
      assert parrot.description == "some description"
      assert parrot.send_parrots == 42
      assert parrot.title == "some title"
    end

    test "create_parrot/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Secta.create_parrot(@invalid_attrs)
    end

    test "update_parrot/2 with valid data updates the parrot" do
      parrot = parrot_fixture()
      assert {:ok, %Parrot{} = parrot} = Secta.update_parrot(parrot, @update_attrs)
      assert parrot.description == "some updated description"
      assert parrot.send_parrots == 43
      assert parrot.title == "some updated title"
    end

    test "update_parrot/2 with invalid data returns error changeset" do
      parrot = parrot_fixture()
      assert {:error, %Ecto.Changeset{}} = Secta.update_parrot(parrot, @invalid_attrs)
      assert parrot == Secta.get_parrot!(parrot.id)
    end

    test "delete_parrot/1 deletes the parrot" do
      parrot = parrot_fixture()
      assert {:ok, %Parrot{}} = Secta.delete_parrot(parrot)
      assert_raise Ecto.NoResultsError, fn -> Secta.get_parrot!(parrot.id) end
    end

    test "change_parrot/1 returns a parrot changeset" do
      parrot = parrot_fixture()
      assert %Ecto.Changeset{} = Secta.change_parrot(parrot)
    end
  end
end
