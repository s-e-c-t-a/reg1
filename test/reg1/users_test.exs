defmodule Reg1.UsersTest do
  use Reg1.DataCase

  alias Reg1.Users

  describe "scores" do
    alias Reg1.Users.Score

    @valid_attrs %{wallet: 42}
    @update_attrs %{wallet: 43}
    @invalid_attrs %{wallet: nil}

    def score_fixture(attrs \\ %{}) do
      {:ok, score} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_score()

      score
    end

    test "list_scores/0 returns all scores" do
      score = score_fixture()
      assert Users.list_scores() == [score]
    end

    test "get_score!/1 returns the score with given id" do
      score = score_fixture()
      assert Users.get_score!(score.id) == score
    end

    test "create_score/1 with valid data creates a score" do
      assert {:ok, %Score{} = score} = Users.create_score(@valid_attrs)
      assert score.wallet == 42
    end

    test "create_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_score(@invalid_attrs)
    end

    test "update_score/2 with valid data updates the score" do
      score = score_fixture()
      assert {:ok, %Score{} = score} = Users.update_score(score, @update_attrs)
      assert score.wallet == 43
    end

    test "update_score/2 with invalid data returns error changeset" do
      score = score_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_score(score, @invalid_attrs)
      assert score == Users.get_score!(score.id)
    end

    test "delete_score/1 deletes the score" do
      score = score_fixture()
      assert {:ok, %Score{}} = Users.delete_score(score)
      assert_raise Ecto.NoResultsError, fn -> Users.get_score!(score.id) end
    end

    test "change_score/1 returns a score changeset" do
      score = score_fixture()
      assert %Ecto.Changeset{} = Users.change_score(score)
    end
  end
end
