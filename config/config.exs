import Config

config :newapp,
  ecto_repos: [Newapp.Repo]

# Configures the endpoint
config :newapp, NewappWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: NewappWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Newapp.PubSub,
  live_view: [signing_salt: "Ji2A/8OK"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
#config :newapp, Newapp.Mailer, adapter: Swoosh.Adapters.Local

config :newapp, Newapp.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "mail.triangulocreativove.com",
  port: 465,
  username: "madagascartv@triangulocreativove.com",
  password: "Santiago*25",
  tls: :if_available,
  ssl: true,
  retries: 1

config :swoosh, :api_client, false

config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :newapp, Newapp.Guardian,
       issuer: "newapp",
       secret_key: "YscGFaXb4Ou3PnosVbmCQlEUINENC7a3yH1hsdlxtbn1x8BJN9gQYjzIK6I0Ym3p"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
