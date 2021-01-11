# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :reg1,
  ecto_repos: [Reg1.Repo]

# Configures the endpoint
config :reg1, Reg1Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HqYwSXD90USfGdm+0g7uv/o79Gh6oQ8F3H5j4u0hGFTGdwTzPdJ6Kary7IqxokkN",
  render_errors: [view: Reg1Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Reg1.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# https://hexdocs.pm/bamboo/Bamboo.LocalAdapter.html
# In config/config.exs, or config/dev.exs, etc.
  config :reg1, Reg1.Mailer,
  adapter: Bamboo.LocalAdapter,
  open_email_in_browser_url: "http://localhost:4000/sent_emails" # optional

config :reg1, :pow,
  user: Reg1.Users.User,
  repo: Reg1.Repo,
  web_module: Reg1Web,
    web_mailer_module: Reg1Web,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: Reg1Web.PowMailer


  # config/config.exs __Bamboo  наверно надо убрать
  # config :reg1, Reg1.Mailer,
  # adapter: Bamboo.LocalAdapter,
  # optional
  # open_email_in_browser_url: "https://localhost:4000/sent_emails"
  ## adapter: Bamboo.MandrillAdapter,
  ## api_key: "my_api_key"




# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
