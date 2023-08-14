#!/bin/bash

rails assets:precompile
rails db:migrate
rails db:seed
bundle exec rails server -e production -p 5555
