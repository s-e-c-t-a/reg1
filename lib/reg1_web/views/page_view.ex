defmodule Reg1Web.PageView do
  use Reg1Web, :view

  alias Reg1Web.Users.Score

  alias Reg1.Users.User

  def view_parrot(%{wallet: wallet}) do
    wallet
  end


 # def avatar(%User{avatar: nil} = user) do
 #   username = user.username |> String.first() |> String.upcase()
 #   content_tag(:div, username, class: "avatar")
 # end
#
#
#  def avatar(%User{avatar: avatar} = user) do
#    Reg1.Avatar.url({avatar, user}, :thumb, signed: true)
#    |> img_tag(class: "avatar")
#  end

end
