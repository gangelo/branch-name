# frozen_string_literal: true

require 'thor'
require_relative '../configurable'
require_relative '../exitable'
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
          def ascestor_name
            'config delete'
          end
        end

        desc 'all', 'Deletes all config files (local and global) for this gem'
        subcommand_help_override "#{ascestor_name} all"
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name config delete all` -- will remove the all .branch-name config files.

          SYNOPSIS
          \x5
          branch-name config delete all
        LONG_DESC
        method_option :all, type: :boolean, aliases: '-a'

        def all
          delete_global_config_file!
          delete_local_config_file!
        end

        desc 'global', 'Deletes the global config file for this gem'
        subcommand_help_override "#{ascestor_name} global"
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name config delete global` -- will remove the global .branch-name config file.

          SYNOPSIS
          \x5
          branch-name config delete global
        LONG_DESC
        method_option :global, type: :boolean, aliases: '-g'

        def global
          delete_global_config_file!
        end

        desc 'local', 'Deletes the local config file for this gem'
        subcommand_help_override "#{ascestor_name} local"
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name config delete local` -- will remove the local .branch-name config file.

          SYNOPSIS
          \x5
          branch-name config delete local
        LONG_DESC
        method_option :local, type: :boolean, aliases: '-l'

        def local
          delete_local_config_file!
        end
      end
    end
  end
end
