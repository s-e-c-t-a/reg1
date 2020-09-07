defmodule Reg1Web.PowResetPassword.MailerView do
  use Reg1Web, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end
