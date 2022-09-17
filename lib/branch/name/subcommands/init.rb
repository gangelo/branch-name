# frozen_string_literal: true

require 'colorize'
require 'thor'
require_relative '../configurable'

module Branch
  module Name
    module Subcommands
      # https://www.atlassian.com/git/tutorials/setting-up-a-repository/git-config
      class Init < ::Thor
        include Configurable

        class << self
          def exit_on_failure?
            false
          end
        end

        default_task :global

        desc 'global', 'Creates and initializes a .branch-nameconfig file in the global folder'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name init global` -- will create and initialize a .branch-nameconfig file
          in the "#{Locatable.global_folder}" folder.

          SYNOPSIS
          \x5
          branch-name init global
        LONG_DESC
        def global
          if create_global_config_file!
            say "Global config file created \"#{global_config_file}\"", :green
          else
            say "Global config file already exists \"#{global_config_file}\"", :yellow
          end
        end

        desc 'local', 'Creates and initializes a .branch-nameconfig file in the local folder'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name init local` -- will create and initialize a .branch-nameconfig file
          in the "#{Locatable.local_folder}" folder.

          SYNOPSIS
          \x5
          branch-name init local
        LONG_DESC
        def local
          if create_local_config_file!
            say "Local config file created \"#{local_config_file}\"", :green
          else
            say "Local config file already exists \"#{local_config_file}\"", :yellow
          end
        end

        desc 'system', 'Creates and initializes a .branch-nameconfig file in the system folder'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name init system` -- will create and initialize a .branch-nameconfig file
          in the "#{Locatable.system_folder}" folder.

          SYNOPSIS
          \x5
          branch-name init system
        LONG_DESC
        def system
          # if create_system_config_file!
          #   say "System config file created \"#{system_config_file}\"", :green
          # else
          #   say "System config file already exists \"#{system_config_file}\"", :yellow
          # end
          say_error 'System initialization is not available at this time', :red
          exit 1
        end
      end
    end
  end
end
