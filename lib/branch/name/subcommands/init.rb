# frozen_string_literal: true

require 'thor'
require_relative '../configurable'
require_relative '../exitable'
require_relative 'nestable'

module Branch
  module Name
    module Subcommands
      # https://www.atlassian.com/git/tutorials/setting-up-a-repository/git-config
      class Init < ::Thor
        include Configurable
        include Exitable
        include Nestable

        class << self
          def ascestor_name
            'config init'
          end

          def subcommand_help_map
            {
              global: "#{ascestor_name} global",
              help: "#{ascestor_name} help [SUBCOMMAND]",
              local: "#{ascestor_name} local",
            }
          end
        end

        default_task :global

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
