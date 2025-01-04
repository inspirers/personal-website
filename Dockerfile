FROM nginx:alpine
# JEKYLL_ENV=production bundle exec jekyll b
COPY _site /usr/share/nginx/html
# COPY ads.txt /usr/share/nginx/html
