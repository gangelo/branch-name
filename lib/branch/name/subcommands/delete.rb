# frozen_string_literal: true

require 'thor'
require_relative '../configurable'
require_relative '../exitable'
require_relative 'help_nestable'
require_relative 'nestable'
require_relative '../task_defaultable'

module Branch
  module Name
    module Subcommands
      class Delete < ::Thor
        include Configurable
        include Exitable
        include Nestable
        include TaskDefaultable

        class << self
          def ancestor_name
            'config delete'
          end
        end

        # NOTE: This must be included AFTER defining .ancestor_name
        include HelpNestable

        desc 'all', 'Deletes all config files (local and global) for this gem'
        help_override "#{ancestor_name} all"
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
        help_override "#{ancestor_name} global"
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
        help_override "#{ancestor_name} local"
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
