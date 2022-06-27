import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :security_web, SecurityWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "fjCYjEQJHnG71EGxUJwgDpReEATF5PmrF3myHvV+9WOKEzbvfobOfcfFoOXrQ5Fn",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
