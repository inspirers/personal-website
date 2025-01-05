#!/usr/bin/env bash
JEKYLL_ENV=production bundle exec jekyll b
docker compose up --build -d