#!/bin/bash
# Forwards the Nginx error.log to the Docker logs.
set -e
if [[ -e /var/log/nginx/error.log ]]; then
	exec tail -F /var/log/nginx/error.log
else
	exec sleep 10
fi
