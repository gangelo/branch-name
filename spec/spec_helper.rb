# frozen_string_literal: true

require 'pry-byebug'
require 'thor'

require 'simplecov'
SimpleCov.start

SimpleCov.start do
  add_filter 'spec'
end

require 'branch/name/cli'
Dir[File.join(Dir.pwd, 'spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include ConfigFileHelpers
end
