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
      pre_wallet = Repo.all(query)
         IO.puts "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
         IO.inspect(pre_wallet)
         IO.puts "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"   

               case length(pre_wallet) do
                    0 -> "Тут живут попугаи"
       
                    _ -> pre_wallet2 = hd(pre_wallet)
                    pre_wallet2.wallet
       
               end
  end

   
 def your_number(current_user) do
      
      itog = current_user.id
      
 end



end
