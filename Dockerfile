FROM jekyll/builder:latest as build
LABEL maintainer="biggerfisch@gmail.com"

# Adding these first allows the install to be cached as a layer
RUN bundle config set --local deployment 'true'
ADD Gemfile Gemfile.lock _config.yml /srv/jekyll/
WORKDIR /srv/jekyll

ADD . /srv/jekyll

# Need to copy out of /srv/jekyll since that is overwritten by a volume in the jekyll parent image .-.
RUN jekyll build && \
    cp -R /srv/jekyll/_site /srv/_site

FROM nginx:alpine
WORKDIR /usr/share/nginx/html

# Takes the built site and makes it accessible to nginx
COPY --from=build /srv/_site/ .
COPY --from=build /srv/jekyll/nginx.conf /etc/nginx/nginx.conf

EXPOSE 3000 

CMD ["nginx"]
