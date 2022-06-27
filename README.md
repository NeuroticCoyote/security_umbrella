# Security.Umbrella

# Run the App
Build from scratch and enter the following command:
    iex -S mix phx.server

Go to `http://localhost:4000/` to test it is up and running. Build can be found under _build/dev.

# Usage
    iex(1)> :code_lock.start_link(["1", "2"])
    {:error, {:already_started, #PID<0.447.0>}}
    iex(2)> :code_lock.button("1")
    :ok

# Deps
`mix deps.get`

# Releases
To initialise the release:
`mix phx.digest`     - to create the cache_manifest.json
`mix release.init`
Create the mix release:
`MIX_ENV=prod mix release security_web`

To run PROD Release:
`MIX_ENV=prod SECRET_KEY_BASE=$(mix phx.gen.secret) _build/prod/rel/security_web/bin/security_web start_iex`
NOTE: this needs a SECRET_KEY_BASE otherwise there will be a runime error.

# Docker
To build:
`docker build -t my_ex_builder:latest .`

To Run:
`docker run -p 4000:4000  my_ex_builder:latest start`

# Skaffold
`skaffold build`