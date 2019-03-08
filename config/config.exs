# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :birin_api,
  ecto_repos: [BirinApi.Repo]

# Configures the endpoint
config :birin_api, BirinApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SjcsF1dhhkfzEAwYKwJGHaO0l8q8LdwVqpJ2MTwI6Btku2BCM8wBPw1LEIx1x2eI",
  render_errors: [view: BirinApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BirinApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
