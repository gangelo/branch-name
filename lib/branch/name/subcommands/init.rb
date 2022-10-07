# frozen_string_literal: true

require 'thor'
require 'thor_nested_subcommand'
require_relative '../configurable'
require_relative '../exitable'
require_relative '../task_defaultable'

module Branch
  module Name
    module Subcommands
      class Init < ::Thor
        include Configurable
        include Exitable
        include ThorNestedSubcommand
        include TaskDefaultable

        class << self
          def base_usage
            'config init'
          end
        end

        desc 'global', 'Creates and initializes a .branch-name file in the global folder'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name config init global` -- will create and initialize a .branch-name file
          in the "#{Locatable.global_folder}" folder.

          SYNOPSIS
          \x5
          branch-name config init global
        LONG_DESC
        def global
          create_global_config_file!
        end

        desc 'local', 'Creates and initializes a .branch-name file in the local folder'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name config init local` -- will create and initialize a .branch-name file
          in the "#{Locatable.local_folder}" folder.

          SYNOPSIS
          \x5
          branch-name config init local
        LONG_DESC
        def local
          create_local_config_file!
        end
      end
    end
  end
end
