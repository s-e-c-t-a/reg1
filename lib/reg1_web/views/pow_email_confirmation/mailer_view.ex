defmodule Reg1Web.PowEmailConfirmation.MailerView do
  use Reg1Web, :mailer_view

  def subject(:email_confirmation, _assigns), do: "Confirm your email address"
end
