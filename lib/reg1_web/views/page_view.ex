defmodule Reg1Web.PageView do
  use Reg1Web, :view

  alias Reg1Web.Users.Score

  def view_parrot(%{wallet: wallet}) do
    wallet
  end
end
