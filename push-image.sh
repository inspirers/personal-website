#!/usr/bin/env bash
JEKYLL_ENV=production bundle exec jekyll b
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t registry.boisen.io:8443/arvid.boisen/boisen.io-website:latest --push .


# docker build -t registry.boisen.io:8443/arvid.boisen/boisen.io-website:latest .
# docker push registry.boisen.io:8443/arvid.boisen/boisen.io-website:latest

# docker build --platform linux/arm64 -t registry.boisen.io:8443/arvid.boisen/boisen.io-website:latest .
# docker push registry.boisen.io:8443/arvid.boisen/boisen.io-website:latest
# curl -X POST https://portainer.boisen.io/api/webhooks/17adbf4a-e595-4e17-a39e-5d0e6730685c