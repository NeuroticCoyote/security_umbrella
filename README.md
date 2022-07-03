# Security.Umbrella

# Pre-requisites
The following must be installed:
Elixir: https://elixir-lang.org/install.html
Erlang: https://www.erlang.org/downloads
Docker: https://docs.docker.com/get-docker/
Skaffold: https://skaffold.dev/
Terraform: https://www.terraform.io/downloads
Npm >= v8: https://docs.npmjs.com/downloading-and-installing-node-js-and-npm

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

# Terraform
## Docker
To initialise and apply:
```
cd infra/cloud/docker/
terraform init
terraform apply
```
Test by running docker ps.

To destroy:
`terraform destroy`

## Linode
Make sure to export the Linode API token:
```
export TF_VAR_linode_token=TOKEN_HERE
export LINODE_TOKEN=${TF_VAR_linode_token}
```
Then:
```
cd infra/cloud/linode/lke
terraform init
terraform apply
```