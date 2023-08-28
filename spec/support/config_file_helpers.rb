# frozen_string_literal: true

module ConfigFileHelpers
  def with_global_config_file!
    Branch::Name::CLI.start(%w[config init global])
  end

  def with_local_config_file!
    Branch::Name::CLI.start(%w[config init local])
  end

  def create_configuration
    Class.new(Thor) do
      require 'thor'
      include Branch::Name::Loadable
    end.new
  end
end
