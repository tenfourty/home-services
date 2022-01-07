#!/bin/bash
# quick script to update all my containers and restart them

#cd /share/Container
docker-compose down
docker-compose up -d
docker-compose ps
