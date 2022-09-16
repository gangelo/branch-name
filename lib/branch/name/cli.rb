# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/object/blank'
require 'bundler'
require 'colorize'
require 'thor'
require_relative 'configurable'
require_relative 'locatable'
require_relative 'version'

module Branch
  module Name
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
        `branch-name global` -- will create and initialize a .branch-nameconfig file
        in the "#{Locatable.global_folder}" folder.

        SYNOPSIS
        \x5
        branch-name global
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
        `branch-name local` -- will create and initialize a .branch-nameconfig file
        in the "#{Locatable.local_folder}" folder.

        SYNOPSIS
        \x5
        branch-name local
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
        `branch-name system` -- will create and initialize a .branch-nameconfig file
        in the "#{Locatable.system_folder}" folder.

        SYNOPSIS
        \x5
        branch-name system
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

    #
    # The `branch-name` command.
    #
    class CLI < ::Thor
      include Locatable

      class << self
        def exit_on_failure?
          false
        end
      end

      default_task :create
      map %w[--version -v] => :version

      desc 'create [OPTIONS] TICKET [DESCRIPTION]', 'Formulate a branch name based on a ticket and optional description'
      long_desc <<-LONG_DESC
        NAME
        \x5
        `branch-name create` -- will formulate a Git branch name based on the TICKET and optional DECRIPTION provided.

        SYNOPSIS
        \x5
        branch-name create [-dsp] TICKET [DESCRIPTION]

        \x5
        The following options are available:

        \x5 -d: Forces the branch name to lower case.
                The default is --no-downcase

        \x5\x5 -s DELIMITER: Indicates the DELIMITER that will be used to delimit tokens in the branch name.
               The default DELIMITER is the '_' (underscore) character.

        \x5\x5 -p LOCATION: Indicates that a project should be created.
               A "project" is a folder that is created in the LOCATION specified
               whose name is equivalent to the branch name that is formulated.
               The default LOCATION is #{Locatable.project_folder(options: options)}.

        \x5 -f: Used with the -p option. If -f is specified, scratch.rb and readme.txt files
            will be created in the project folder created.
            The default is --project-files
      LONG_DESC
      method_option :downcase, type: :boolean, aliases: '-d'
      method_option :separator, type: :string, aliases: '-s', default: '_'
      method_option :project, type: :string, aliases: '-p', default: "#{Locatable.project_folder(options: options)}"
      method_option :project_files, type: :boolean, aliases: '-f', default: true

      def create(ticket, ticket_description = nil)
        if ticket.blank? && ticket_description.blank?
          say_error 'ticket and/or ticket_description is required', :red
          exit 1
        end

        branch_name = "#{ticket} #{ticket_description}".strip
        branch_name = branch_name.split.join options[:separator]
        branch_name = branch_name.downcase if options[:downcase]
        branch_name = branch_name.tr('_', '-') if options[:separator] == '-'
        branch_name = branch_name.tr('-', '_') if options[:separator] == '_'
        branch_name = branch_name.squeeze('-') if options[:separator] == '-'
        branch_name = branch_name.squeeze('_') if options[:separator] == '_'

        say branch_name, :cyan

        if /darwin/ =~ RUBY_PLATFORM
          IO.popen('pbcopy', 'w') { |pipe| pipe.puts branch_name }
          say "\"#{branch_name}\" has been copied to the clipboard", :green
        end
      end

      desc 'init SUBCOMMAND ...ARGS', 'Sets up config files for this gem'
      subcommand :init, Init

      desc '--version, -v', 'Displays this gem version'
      def version
        puts Branch::Name::VERSION
      end
    end
  end
end
