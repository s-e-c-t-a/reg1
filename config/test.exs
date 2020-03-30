use Mix.Config

# Configure your database
config :reg1, Reg1.Repo,
  username: "postgres",
  password: "postgres",
  database: "reg1_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :reg1, Reg1Web.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
