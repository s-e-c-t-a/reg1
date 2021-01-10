defmodule Reg1.Email do
    import Bamboo.Email

  def send_email_to_registration do
	new_email(
        to: "john@example.com",
        from: "support@myapp.com",
        subject: "Пришла почта",
        text_body: " нажми на кнопку",
        html_body: "<p> хтмл боди туда сюда <p>" 
		)
    end
end