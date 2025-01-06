#!/usr/bin/env bash
JEKYLL_ENV=production bundle exec jekyll b
docker build -t registry.boisen.io/arvid.boisen/boisen.io-website:latest .
docker push registry.boisen.io/arvid.boisen/boisen.io-website:latest
curl -X POST https://portainer.boisen.io/api/webhooks/17adbf4a-e595-4e17-a39e-5d0e6730685c