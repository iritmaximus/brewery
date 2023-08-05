#!/bin/bash

rails assets:precompile
rails db:migrate
rails db:seed
bundle exec rails server -b 0.0.0.0 -p 5555
