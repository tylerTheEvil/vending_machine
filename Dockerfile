FROM ruby:2.7

RUN gem install bundler -v 1.17.3

ARG APP_HOME=/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock $APP_HOME/
RUN bundle install

VOLUME /usr/local/bundle

ADD . $APP_HOME

CMD ruby start.rb
