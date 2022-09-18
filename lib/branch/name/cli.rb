# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/object/blank'
require 'bundler'
require 'colorize'
require 'thor'
require_relative 'configurable'
require_relative 'exitable'
require_relative 'loadable'
require_relative 'locatable'
require_relative 'subcommands/config'
require_relative 'subcommands/init'
require_relative 'version'

require 'pry'

module Branch
  module Name
    #
    # The `branch-name` command.
    #
    class CLI < ::Thor
      include Exitable
      include Loadable
      include Locatable

      # def options
      #   original_options = super
      #   default_options = load_options
      #   return original_options unless default_options.present?

      #   Thor::CoreExt::HashWithIndifferentAccess.new(default_options.merge(original_options))
      # end

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
      method_option :project, type: :string, aliases: '-p'
      method_option :project_files, type: :boolean, aliases: '-f'

      def create(ticket, ticket_description = nil)
        if ticket.blank? && ticket_description.blank?
          say_error 'ticket and/or ticket_description is required', :red
          exit 1
        end

        puts options

        self.options = Thor::CoreExt::HashWithIndifferentAccess.new(load_options[:create].merge(options))

        puts options

        branch_name = "#{ticket} #{ticket_description}".strip
        branch_name = branch_name.split.join options[:separator]
        branch_name = branch_name.downcase if options[:downcase]
        branch_name = branch_name.tr('_', '-') if options[:separator] == '-'
        branch_name = branch_name.tr('-', '_') if options[:separator] == '_'
        branch_name = branch_name.squeeze('-') if options[:separator] == '-'
        branch_name = branch_name.squeeze('_') if options[:separator] == '_'

        say "Branch name: #{branch_name}", :cyan

        if /darwin/ =~ RUBY_PLATFORM
          IO.popen('pbcopy', 'w') { |pipe| pipe.puts branch_name }
          say "\"#{branch_name}\" has been copied to the clipboard!", :green
        end
      end

      desc 'init SUBCOMMAND', 'Sets up config files for this gem'
      subcommand :init, Branch::Name::Subcommands::Init

      desc 'config SUBCOMMAND', 'Manages config files for this gem'
      subcommand :config, Branch::Name::Subcommands::Config

      desc '--version, -v', 'Displays this gem version'
      def version
        puts Branch::Name::VERSION
      end
    end
  end
end
