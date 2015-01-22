#!/bin/bash
if [[ "$PASSENGER_APP_ENV" != "" ]]; then
	echo "passenger_app_env '$PASSENGER_APP_ENV';" > /etc/nginx/conf.d/00_app_env.conf
fi
