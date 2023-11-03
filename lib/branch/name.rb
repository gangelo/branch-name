# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

if File.exist?("#{__dir__}/lib/.env.development")
  # This loads our development environment when running dev.
  require 'dotenv'
  Dotenv.load('.env.development')
end

require 'pry-byebug' if ENV['BRANCH_NAME_ENV'] == 'development'

Dir.glob("#{__dir__}/name/**/*.rb").each do |file|
  require file
end
