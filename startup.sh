#!/bin/bash

bundle exec rails server -b 0.0.0.0 -p 5555
rails db:migrate
rails db:seed
