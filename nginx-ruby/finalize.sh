#!/bin/bash
set -e
source /build/configuration
set -x

cp /build/setup-system /usr/sbin/setup-system
echo "if [[ -f /usr/sbin/setup-system ]] && tty -s; then echo '*** Please run setup-system ***'; fi" >> /root/.bashrc
echo "if [[ -f /usr/sbin/setup-system ]] && tty -s; then echo '*** Please run setup-system as root ***'; fi" >> /home/app/.bashrc

apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /build
