FROM ruby:3.2.0
RUN apt-get update \
  && apt-get -y install apt-utils build-essential \
  && gem install rails -v '7.0.4'
WORKDIR /base

COPY Gemfile Gemfile.lock /base/
RUN bundle install
COPY . .

