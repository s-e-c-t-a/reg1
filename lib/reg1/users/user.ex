defmodule Reg1.Users.User do
  use Ecto.Schema

  use Arc.Ecto.Schema

  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema,
    extensions: [PowResetPassword, PowEmailConfirmation]
   
   import Ecto.Changeset


  schema "users" do

    field :nick, :string
    field :avatar, Reg1.Avatar.Type
    #Reg1.Avatar.Type   :string

    pow_user_fields()

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
     

    #|> cast(attrs, [:nick]) 
    |> cast(attrs, [:nick])
    |> cast_attachments(attrs, [:avatar]) 
    |> validate_required([:nick])
    |> unique_constraint(:nick)
    |> validate_length(:nick, max: 50)
    |> validate_length(:nick, min: 1)

    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
  end

end
