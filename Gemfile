# frozen_string_literal: true

source 'https://rubygems.org'
ruby '~> 2.6.0'

gem 'aasm'
gem 'activesupport', require: false
gem 'dry-struct'
gem 'gosu'

group :development do
  gem 'reek'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'yard'
end

group :test do
  gem 'rspec'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'pry-byebug'
end
