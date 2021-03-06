# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :garland,
  ecto_repos: [Garland.Repo]

# Configures the endpoint
config :garland, GarlandWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gacPDUQaqJQFPacn8AO7SbAAMlvXwm342RO/s16uzsBISqVzbmvTPgdrFuxOZ6vG",
  render_errors: [view: GarlandWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Garland.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "MB520wK2/hvoTikJ9Y0PgPcM24C9trP7Yw/4SvRbnOVET1VpmkDcs82tum8QGzyh"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix,
  json_library: Jason,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
