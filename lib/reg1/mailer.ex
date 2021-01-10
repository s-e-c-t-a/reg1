defmodule Reg1.Mailer do

  use Pow.Phoenix.Mailer
  require Logger

  @impl true
  def cast(%{user: user, subject: subject, text: text, html: html, assigns: _assigns}) do
    # Build email struct to be used in `process/1`

    %{to: user.email, subject: subject, text: text, html: html}
  end

  @impl true
  def process(email) do
    # Send email
    Reg1.Email.send_email_to_registration

    Logger.debug("E-mail sent: #{inspect email}")
  end

  end