# frozen_string_literal: true

require 'thor'
require_relative '../configurable'
require_relative '../exitable'
require_relative 'thor_nested_subcommand'
require_relative '../task_defaultable'

module Branch
  module Name
    module Subcommands
      class Delete < ::Thor
        include Configurable
        include Exitable
        include ThorNestedSubcommand
        include TaskDefaultable

        class << self
          def base_usage
            'config delete'
          end
        end

        desc 'all', 'Deletes all config files (local and global) for this gem'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name config delete all` -- will remove the all .branch-name config files.

          SYNOPSIS
          \x5
          branch-name config delete all
        LONG_DESC
        def all
          delete_global_config_file!
          delete_local_config_file!
        end

        desc 'global', 'Deletes the global config file for this gem'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name config delete global` -- will remove the global .branch-name config file.

          SYNOPSIS
          \x5
          branch-name config delete global
        LONG_DESC
        def global
          delete_global_config_file!
        end

        desc 'local', 'Deletes the local config file for this gem'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name config delete local` -- will remove the local .branch-name config file.

          SYNOPSIS
          \x5
          branch-name config delete local
        LONG_DESC
        def local
          delete_local_config_file!
        end
      end
    end
  end
end
