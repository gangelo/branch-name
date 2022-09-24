# frozen_string_literal: true

require 'pry-byebug'
require 'thor'

require 'branch/name'
require 'branch/name/clipable'
require 'branch/name/configurable'
require 'branch/name/exitable'
require 'branch/name/loadable'
require 'branch/name/locatable'
require 'branch/name/normalizable'
require 'branch/name/projectable'
require 'branch/name/version'

Dir[File.join(Dir.pwd, 'spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
