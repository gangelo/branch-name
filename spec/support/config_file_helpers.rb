# frozen_string_literal: true

module ConfigFileHelpers
  def with_global_config_file!
    Branch::Name::CLI.start(%w[config init global])
  end

  def with_local_config_file!
    Branch::Name::CLI.start(%w[config init local])
  end
end
