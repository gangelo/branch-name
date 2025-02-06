# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in branch-name.gemspec
gemspec

gem 'bundler', '>= 2.5', '< 3.0'
gem 'rake', '>= 13.0', '< 14.0'

group :development do
  gem 'reek', '>= 6.1', '< 7.0'
  gem 'rubocop', '>= 1.35', '< 2.0'
  gem 'rubocop-performance', '>= 1.14', '< 2.0'
  gem 'rubocop-rspec', '>= 2.12', '< 3.0'
end

group :test do
  gem 'rspec', '>= 3.12', '< 4.0'
  gem 'rspec-activemodel-mocks', '>= 1.1', '< 2.0'
  gem 'shoulda-matchers', '>= 6.0', '< 7.0'
  gem 'simplecov', '>= 0.22', '< 2.0'
end

group :development, :test do
  gem 'dotenv', '>= 2.8', '< 4.0'
  gem 'irb', '~> 1.15', '>= 1.15.1'
  gem 'pry-byebug', '>= 3.9', '< 4.0'
  gem 'thor', '>= 1.3', '< 2.0'
end
