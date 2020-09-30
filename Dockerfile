FROM ruby:2.6.1

RUN mkdir /myapp
WORKDIR /myapp
RUN gem install bundler:2.1.4
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . /myapp

CMD ["/bin/bash", "-c", "bundle exec exec puma -b tcp://0.0.0.0 -p 3000"]
