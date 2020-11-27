defmodule Reg1Web.LayoutView do
  use Reg1Web, :view

  import Ecto.Query, warn: false
  
  alias Reg1.Repo
  alias Reg1.Users.Score

  def title(conn) do
    find_id = conn.assigns.current_user.id

      query =
      from s in Score,
      where: s.user_id == ^find_id 
      [pre_wallet] = Repo.all(query)

      find_wallet = pre_wallet.wallet
  IO.puts "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
    IO.inspect(find_wallet)
    IO.puts "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
     find_wallet
 
  end

end

## <%= inspect ahz %>
                   
          ##         <%= for title_huitle <- ahz do %>
          ##         <%= title_huitle.wallet %>
          ##         <% end %> 