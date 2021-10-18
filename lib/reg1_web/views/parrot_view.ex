defmodule Reg1Web.ParrotView do
  use Reg1Web, :view

   def title_mail(parrot_title) do
    
     Reg1.Users.find_mail(parrot_title)

   end



end
