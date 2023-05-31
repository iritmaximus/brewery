FROM ruby:3.1.2

ENV PORT 3000
EXPOSE $PORT

WORKDIR /home/app

RUN apt-get update && apt-get install -y npm && npm install -g yarn

COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .

ENTRYPOINT ["/bin/bash"]
CMD ["startup.sh"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "5555"]
