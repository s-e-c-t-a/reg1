defmodule Reg1.Repo do
  use Ecto.Repo,
    otp_app: :reg1,
    adapter: Ecto.Adapters.Postgres
end
