# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/object/blank'
require 'bundler'
require 'thor'
require_relative 'clipable'
require_relative 'configurable'
require_relative 'exitable'
require_relative 'loadable'
require_relative 'locatable'
require_relative 'normalizable'
require_relative 'projectable'
require_relative 'subcommands/config'
require_relative 'task_defaultable'
require_relative 'version'

module Branch
  module Name
    #
    # The `branch-name` command.
    #
    class CLI < ::Thor
      include Clipable
      include Exitable
      include Loadable
      include Locatable
      include Normalizable
      include Projectable
      include TaskDefaultable

      class_option :debug, type: :boolean, default: false
      class_option :verbose, type: :boolean, default: false

      map %w[--version -v] => :version

      desc 'create [OPTIONS] DESCRIPTION [TICKET]', 'Formulate a branch name based on a ticket
        description and optional ticket'
      long_desc <<-LONG_DESC
        NAME
        \x5
        `branch-name create` -- will formulate a Git branch name based on the
        DESCRIPTION and optional TICKET provided.

        SYNOPSIS
        \x5
        branch-name create [-l|-f|-d|-s|-p|-x] DESCRIPTION [TICKET]

        \x5
        The following options are available:

        \x5 NOTE: Default option values will be overidden if .branch-name config files
        are present. Run `branch-name config info` to determine what config files
        are present.

        \x5 -d: Forces the branch name to lower case.
                The default is: #{DEFAULT_BRANCH_NAME_OPTIONS['create']['downcase']}.

        \x5\x5 -s SEPARATOR: Indicates the SEPARATOR that will be used to delimit tokens in the branch name.
               The default SEPARATOR is: '#{DEFAULT_BRANCH_NAME_OPTIONS['create']['separator']}'.

        \x5\x5 -p: Indicates that a project should be created.
               The default is: #{DEFAULT_BRANCH_NAME_OPTIONS['create']['project']}.

        \x5 -f: Used with the -p option. If -f is specified, project files
            will be created in the PROJECT_LOCATION specified by the -l option.
            The default is: #{DEFAULT_BRANCH_NAME_OPTIONS['create']['project_files']}.

        \x5\x5 -l PROJECT_LOCATION: Indicates where the project should be created.
            A "project" is a folder that is created in the PROJECT_LOCATION specified,
            whose name is equivalent to the branch name that is formulated.
            The default is: "#{Locatable.project_folder(options: options)}".

        \x5 -x FORMAT_STRING: This is a string that determines the format of the branch name
            that is formulated. The following are a list of required placeholders you must put
            in your format string to format the brach name: [%t, %d].
            \x5Where %t will be replaced by the ticket.
            \x5Where %d will be replaced by the ticket description.
            \x5The default is: "#{DEFAULT_BRANCH_NAME_OPTIONS['create']['format_string']}".
      LONG_DESC
      method_option :downcase, type: :boolean, aliases: '-d'
      method_option :separator, type: :string, aliases: '-s'
      method_option :format_string, type: :string, aliases: '-x'
      method_option :project, type: :boolean, aliases: '-p'
      method_option :project_location, type: :string, aliases: '-l'
      method_option :project_files, type: :array, aliases: '-f'

      def create(ticket_description, ticket = nil)
        if ticket_description.blank?
          say_error 'description is required', :red
          exit 1
        end

        init_options_for! command: :create

        branch_name = normalize_branch_name(ticket_description, ticket) do |error|
          say_error error.message
          exit 1
        end

        say "Branch name: #{branch_name}", :cyan

        say "\"#{branch_name}\" has been copied to the clipboard!", :green if copy_to_clipboard branch_name

        create_project!(branch_name) if options[:project]
      end

      desc 'config SUBCOMMAND', 'Manages config files for this gem'
      subcommand :config, Branch::Name::Subcommands::Config

      desc '--version, -v', 'Displays this gem version'
      def version
        say Branch::Name::VERSION
      end

      private

      def init_options_for!(command:)
        say "Options before config file merge: #{options}" if options[:debug]

        load_options = load_options(defaults: DEFAULT_BRANCH_NAME_OPTIONS)[command.to_s] || {}
        say "No options loaded from config file(s): #{load_options}" if options[:debug] && load_options.blank?
        say "Options loaded from config file(s): #{load_options}" if options[:debug]

        self.options = Thor::CoreExt::HashWithIndifferentAccess.new(load_options.merge(options))
        say "Options after config file merge: #{options}" if options[:debug]
      end
    end
  end
end
