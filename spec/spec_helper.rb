# frozen_string_literal: true

require 'pry-byebug'
require 'shoulda/matchers'
require 'thor'

require 'simplecov'
SimpleCov.start

SimpleCov.start do
  add_filter 'spec'
end

if File.exist?('.env.test')
  # This loads our test environment when running tests.
  require 'dotenv'
  Dotenv.load('.env.test')
end

require 'branch/name'
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

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :active_record
    with.library :active_model
  end
end
