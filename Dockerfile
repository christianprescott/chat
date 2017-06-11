FROM ruby:2.4

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV APP_HOME /usr/src/app
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock $APP_HOME/
RUN bundle install
COPY . $APP_HOME/

EXPOSE 80
CMD rails s -p 80 -b 0.0.0.0
