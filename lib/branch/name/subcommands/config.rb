# frozen_string_literal: true

require 'thor'
require_relative '../configurable'
require_relative '../exitable'
require_relative 'init'

module Branch
  module Name
    module Subcommands
      class Config < ::Thor
        include Configurable
        include Exitable

        default_task :info

        desc 'info', 'Displays information about this gem configuration'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name config info` -- Displays information about this gem configuration.

          SYNOPSIS
          \x5
          branch-name config info
        LONG_DESC
        def info
          if global_config_file?
            say "Global config file exists: \"#{global_config_file}\"", :green
          else
            say "Global config file does not exist at: \"#{global_folder}\"", :yellow
          end

          if local_config_file?
            say "Local config file exists: \"#{local_config_file}\"", :green
          else
            say "Local config file does not exist at: \"#{local_folder}\"", :yellow
          end

          if system_config_file?
            say "System config file exists: \"#{system_config_file}\"", :green
          else
            say "System config file does not exist at: \"#{system_folder}\"", :yellow
          end
        end

        desc 'delete [OPTION]', 'Removes .branch-name file(s)'
        long_desc <<-LONG_DESC
          NAME
          \x5
          `branch-name config delete [OPTION]` -- will remove one or all .branch-name file(s)
          depending on the OPTION.

          SYNOPSIS
          \x5
          branch-name config delete [-a|-g|-l|-s]
        LONG_DESC
        method_option :all, type: :boolean, aliases: '-a'
        method_option :global, type: :boolean, aliases: '-g'
        method_option :local, type: :boolean, aliases: '-l'
        method_option :system, type: :boolean, aliases: '-s'

        def delete
          if options[:all]
            delete_global_config_file!
            delete_local_config_file!
            delete_system_config_file!
          elsif options[:global]
            delete_global_config_file!
          elsif options[:local]
            delete_local_config_file!
          elsif options[:system]
            delete_system_config_file!
          end
        end

        desc 'init SUBCOMMAND', 'Sets up config files for this gem'
        subcommand :init, Branch::Name::Subcommands::Init
      end
    end
  end
end
