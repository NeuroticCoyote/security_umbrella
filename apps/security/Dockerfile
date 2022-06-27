# THIS IS THE DOCKERFILE IF RUNNING ERLANG APP AS STANDALONE
ARG ALPINE_VERSION=3.14.2
ARG ERLANG_VERSION=24.1.6
# Builder Stage
#
# This builder stage is similar to a development environment. All tools and
# compile-time dependencies are packed here.
#
FROM hexpm/erlang:$ERLANG_VERSION-alpine-$ALPINE_VERSION as builder

RUN apk add --no-cache 'build-base=~0.5' && \
    apk add --no-cache 'curl=~7' && \
    rm -rf /var/cache/apk/

RUN set -xe \
    && curl -fSL -o rebar3 "https://s3.amazonaws.com/rebar3-nightly/rebar3" \
    && chmod +x ./rebar3 \
    && ./rebar3 local install \
    && rm ./rebar3

ENV PATH "$PATH:/root/.cache/rebar3/bin"

ENV REL_ENV=${REL_ENV:-prod}

WORKDIR /tmp

COPY src src
COPY config config
COPY rebar.config rebar.config

RUN rebar3 as ${REL_ENV} release

###
### Default Stage
###
### This stage packages the monolithic release built in the previous stage with
### the minimum system requirement to run it. This is the image that is used when
### running the project with Docker.
###

FROM alpine:$ALPINE_VERSION

RUN apk add --no-cache 'openssl=~1.1' && \
 apk add --no-cache 'ncurses-libs=~6' && \
 apk add --no-cache 'libstdc++=~10.3' && \
 rm -rf /var/cache/apk/

WORKDIR /opt

COPY --from=builder /tmp/_build/prod/rel/security ./

CMD ["foreground"]
ENTRYPOINT ["bin/security"]