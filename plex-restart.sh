#!/bin/bash
# quick script to restart plex when there is an issue

cd /share/Container
#docker-compose pull
docker-compose rm -fsv plex
docker-compose up -d
docker-compose ps