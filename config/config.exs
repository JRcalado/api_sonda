# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :my_phx_app, MyPhxAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "l/UVijAwA4VT6yb4jFF3A6KUF2BzZV/92LPHf+bDNR/farS9VuATicWm4XUVlfEX",
  render_errors: [view: MyPhxAppWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MyPhxApp.PubSub,
  live_view: [signing_salt: "RtwKZ3qO"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
