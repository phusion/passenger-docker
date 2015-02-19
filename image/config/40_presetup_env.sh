#!/bin/bash

SETUP_ENV="RAILS_ENV RACK_ENV WSGI_ENV NODE_ENV"
SETUP_VALUE=${PASSENGER_APP_ENV:-production}

for VAR in ${SETUP_ENV}; do
  if [ -z ${!VAR:+x} ]; then
    echo ${SETUP_VALUE} > /etc/container_environment/${VAR}
  fi
done
