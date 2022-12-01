# Dockerfile

FROM ruby:2.7.4

RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    build-essential \
    sqlite3 \ 
    libsqlite3-dev 


WORKDIR /usr/src/web
COPY . /usr/src/web

COPY Gemfile Gemfile.lock ./

RUN bundle install

EXPOSE 3000

# CMD ["/bin/sh", "-c", "bash"]

