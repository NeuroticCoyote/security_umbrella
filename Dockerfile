# THIS IS THE DOCKERFILE FOR ELIXIR UMBRELLA
ARG ALPINE_VERSION=3.14.2
ARG ERLANG_VERSION=24.1.6
ARG ELIXIR_VERSION=1.13.3
ARG MIX_ENV

# Builder Stage
#
# This builder stage is similar to a development environment. All tools and
# compile-time dependencies are packed here.
#

FROM hexpm/elixir:$ELIXIR_VERSION-erlang-$ERLANG_VERSION-alpine-$ALPINE_VERSION as build

ENV MIX_ENV=${MIX_ENV:-prod}

WORKDIR /opt/source

RUN mix local.hex --force \
  && mix local.rebar --force \
  && apk add --no-cache 'nodejs=~14' \
  && apk add --no-cache 'npm=~7'

COPY config config
COPY mix.exs mix.lock ./
COPY apps/security_web/mix.exs apps/security_web/mix.exs

COPY apps/security/src apps/security/src
# COPY apps/security/config apps/security/config
COPY apps/security/rebar.config apps/security/rebar.config

RUN mix setup \
  && mix deps.compile

COPY rel rel
COPY apps/security_web/assets apps/security_web/assets
COPY apps/security_web/lib apps/security_web/lib
COPY apps/security_web/priv apps/security_web/assets/priv

RUN mix assets.deploy \
  && mix release security_web --path out

FROM alpine:$ALPINE_VERSION AS default

EXPOSE 4000

ENV SECRET_KEY_BASE=ZH1b3AUEvZOslobrqo+JihfIK7C6tMYw6MTQa0tjN7DdrIyGp2wMP5KeW7CSBiD4

WORKDIR /opt

RUN apk add --no-cache 'ncurses=~6' \
  && apk add --no-cache 'openssl=~1.1' \
  && apk add --no-cache 'libstdc++=~10.3'

COPY --from=build /opt/source/out/ ./

CMD ["start"]
ENTRYPOINT ["bin/security_web"]