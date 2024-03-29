# frozen_string_literal: true

require 'thor'
require_relative '../configurable'
require_relative '../exitable'
require_relative 'delete'
require_relative 'init'
require_relative '../task_defaultable'

module Branch
  module Name
    module Subcommands
      class Config < ::Thor
        include Configurable
        include Exitable
        include TaskDefaultable

        desc 'info', 'Displays information about this gem configuration'
        long_desc <<-LONG_DESC
          NAME

          `branch-name config info` -- Displays information about this gem configuration.

          SYNOPSIS

          branch-name config info
        LONG_DESC
        def info
          print_global_config_file
          say ''

          if global_folder?
            say 'NOTE: You are in your global folder. ' \
                'Local and global configurations are the same.'.colorize(:yellow)
            return
          end

          print_local_config_file
        end

        desc 'init SUBCOMMAND', 'Sets up config files for this gem'
        subcommand :init, Branch::Name::Subcommands::Init

        desc 'delete SUBCOMMAND', 'Deletes one of all config files for this gem'
        subcommand :delete, Branch::Name::Subcommands::Delete
      end
    end
  end
end
