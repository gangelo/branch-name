# frozen_string_literal: true

require 'thor'
require_relative '../configurable'
require_relative '../exitable'

module Branch
  module Name
    module Subcommands
      # https://www.atlassian.com/git/tutorials/setting-up-a-repository/git-config
      class Init < ::Thor
        include Configurable
        include Exitable

        default_task :global

        desc 'global', 'Creates and initializes a .branch-name file in the global folder'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name init global` -- will create and initialize a .branch-name file
          in the "#{Locatable.global_folder}" folder.

          SYNOPSIS
          \x5
          branch-name init global
        LONG_DESC
        def global
          create_global_config_file!
        end

        desc 'local', 'Creates and initializes a .branch-name file in the local folder'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name init local` -- will create and initialize a .branch-name file
          in the "#{Locatable.local_folder}" folder.

          SYNOPSIS
          \x5
          branch-name init local
        LONG_DESC
        def local
          create_local_config_file!
        end

        desc 'system', 'Creates and initializes a .branch-name file in the system folder'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name init system` -- will create and initialize a .branch-name file
          in the "#{Locatable.system_folder}" folder.

          SYNOPSIS
          \x5
          branch-name init system
        LONG_DESC
        def system
          # create_system_config_file!
          say_error 'System initialization is not available at this time', :red
          exit 1
        end
      end
    end
  end
end
