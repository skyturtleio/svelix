# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :bun,
  version: "1.2.2",
  dev: [
    args: ~w(x --bun vite),
    cd: Path.expand("../assets", __DIR__),
    env: %{}
  ],
  install: [
    args: ~w(i),
    cd: Path.expand("../assets", __DIR__),
    env: %{}
  ],
  build: [
    args: ~w(x --bun vite build),
    cd: Path.expand("../assets", __DIR__),
    env: %{}
  ],
  css: [
    args: ~w(run tailwindcss --input=css/app.css --output=../priv/static/assets/app.css),
    cd: Path.expand("../assets", __DIR__),
    env: %{}
  ]

config :svelix,
  ecto_repos: [Svelix.Repo],
  env: config_env(),
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :svelix, SvelixWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: SvelixWeb.ErrorHTML, json: SvelixWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Svelix.PubSub,
  live_view: [signing_salt: "iKM3WUYw"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :svelix, Svelix.Mailer, adapter: Swoosh.Adapters.Local

# Configure Inertia adapter for Phoenix
config :inertia,
  # The Phoenix Endpoint module for your application. This is used for building
  # asset URLs to compute a unique version hash to track when something has
  # changed (and a reload is required on the frontend).
  endpoint: SvelixWeb.Endpoint,

  # An optional list of static file paths to track for changes. You'll generally
  # want to include any JavaScript assets that may require a page refresh when
  # modified.
  static_paths: ["/assets/app.js"],

  # The default version string to use (if you decide not to track any static
  # assets using the `static_paths` config). Defaults to "1".
  default_version: "1",

  # Enable automatic conversion of prop keys from snake case (e.g. `inserted_at`),
  # which is conventional in Elixir, to camel case (e.g. `insertedAt`), which is
  # conventional in JavaScript. Defaults to `false`.
  camelize_props: false,

  # Instruct the client side whether to encrypt the page object in the window history 
  # state. This can also be set/overridden on a per-request basis, using the `encrypt_history`
  # controller helper. Defaults to `false`.
  history: [encrypt: false],

  # Enable server-side rendering for page responses (requires some additional setup,
  # see instructions below). Defaults to `false`.
  ssr: false,

  # Whether to raise an exception when server-side rendering fails (only applies
  # when SSR is enabled). Defaults to `true`.
  #
  # Recommended: enable in non-production environments and disable in production,
  # so that SSR failures will not cause 500 errors (but instead will fallback to
  # CSR).
  raise_on_ssr_failure: config_env() != :prod

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
