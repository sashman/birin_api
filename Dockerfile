FROM bitwalker/alpine-elixir-phoenix:1.8.1 as BASE

RUN apk update && apk upgrade && apk add bash
WORKDIR /usr/src/

COPY mix.exs mix.lock VERSION /usr/src/
RUN mix do local.hex --force, local.rebar --force
RUN mix do deps.get, compile

COPY . /usr/src/


# Test image
# --------------------------------
FROM BASE as TEST

ENV MIX_ENV=test
CMD [ "mix", "test" ]

# Build executible
# --------------------------------
FROM BASE as BUILD

ARG APP_NAME=birin_api
# The environment to build with
ARG MIX_ENV=prod
ENV MIX_ENV=prod
# The port for the webservice
ARG PORT=4000

RUN \
    mkdir -p /opt/built && \
    mix distillery.init --no-doc && \
    mix distillery.release --verbose --env=prod && \
    export APP_VSN=$(cat VERSION) && \
    cp _build/prod/rel/${APP_NAME}/releases/${APP_VSN}/${APP_NAME}.tar.gz /opt/built && \
    cd /opt/built && \
    tar -xzf ${APP_NAME}.tar.gz && \
    rm ${APP_NAME}.tar.gz

# Prod image
# --------------------------------
FROM elixir:1.8.1-alpine as PROD

RUN apk update && \
    apk add --no-cache \
    bash \
    openssl-dev

WORKDIR /opt/app

COPY --from=BUILD /opt/built .

ENV MIX_ENV=prod
ENV PORT=4000

CMD [ "/opt/app/bin/birin_api", "foreground" ]