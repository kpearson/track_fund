source 'https://rubygems.org'

gem "dotenv-rails", :groups => [:development, :test]
gem 'rails', '4.2.1'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem "bootstrap-sass", "~> 3.2.0"
gem "autoprefixer-rails"
gem "omniauth"
gem "faraday", :require => "faraday"
gem 'sidekiq'
gem 'sidetiq'

group :development, :test do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development do
  gem 'pry'
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara'
  gem 'vcr'
  gem 'simplecov', require: false
  gem "codeclimate-test-reporter", require: false
  gem 'database_cleaner'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
end
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
