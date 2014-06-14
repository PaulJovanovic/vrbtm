source 'https://rubygems.org'

ruby "2.1.1"

gem 'rails', '4.1.1'
gem 'unicorn'

gem 'pg'
gem "font-awesome-rails"
gem 'bootstrap-sass', '~> 3.1.1'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jbuilder', '~> 1.2'
gem 'devise'
gem 'friendly_id'
gem 'will_paginate', '~> 3.0'
gem "paperclip"
gem 'aws-sdk'
gem 'memcachier'
gem 'dalli'
gem 'omniauth-facebook'

group :development do
  gem 'mysql2'
  gem 'foreman'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'pry-rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'mocha', require: false
  gem 'factory_girl_rails'
  gem 'therubyracer'
end

group :production do
  gem 'newrelic_rpm'
end

group :doc do
  gem 'sdoc', require: false
end

gem 'rails_12factor', group: :production
