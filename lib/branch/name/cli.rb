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
require_relative 'services/branch_name_service'
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
      include Projectable
      include TaskDefaultable

      class << self
        def exit_on_failure?
          true
        end
      end

      class_option :debug, type: :boolean, default: false
      class_option :verbose, type: :boolean, default: false

      map %w[--version -v] => :version

      desc 'create [OPTIONS] DESCRIPTION [TICKET]', 'Formulate a branch name based on a ticket
        description and optional ticket'
      long_desc <<-LONG_DESC
        NAME

        `branch-name create` -- will formulate a Git branch name based on the
        DESCRIPTION and optional TICKET provided.

        SYNOPSIS

        branch-name create [-i|-l|-f|-d|-s|-p|-x] DESCRIPTION [TICKET]

        The following options are available:

         NOTE: Default option values will be overidden if .branch-name config files
          are present. Run `branch-name config info` to determine what config files
          are present.

         -d: Forces the branch name to lower case.
          The default is: #{DEFAULT_BRANCH_NAME_OPTIONS['create']['downcase']}.

         -f: Used with the -p option. If -f is specified, project files
          will be created in the PROJECT_LOCATION specified by the -l option.
          The default is: #{DEFAULT_BRANCH_NAME_OPTIONS['create']['project_files']}.

         -i: Interactive. Used only with the -p option. If -i is specified, you will
          be prompted when creating project folders. If -i is not specified, you will
          NOT be prompted when creating project folders.

         -l PROJECT_LOCATION: Indicates where the project should be created.
          A "project" is a folder that is created in the PROJECT_LOCATION specified,
          whose name is equivalent to the branch name that is formulated.
          The default is: "#{Locatable.project_folder(options: options)}".

         -p: Indicates that a project should be created.
          The default is: #{DEFAULT_BRANCH_NAME_OPTIONS['create']['project']}.

         -s SEPARATOR: Indicates the SEPARATOR that will be used to delimit tokens in the branch name.
          The default SEPARATOR is: '#{DEFAULT_BRANCH_NAME_OPTIONS['create']['separator']}'.

         -x FORMAT_STRING: This is a string that determines the format of the branch name
          that is formulated. The following is a list of required placeholders you must put
          in your format string to format the branch name: [%t, %d].
          Where %t will be replaced by the ticket.
          Where %d will be replaced by the ticket description.
          The following is a list of optional placeholders you may put
          in your format string to format the branch name: [%u].
          Where %u will be replaced with your username (`Etc.getlogin`, https://rubygems.org/gems/etc).
          The default format string is: "#{DEFAULT_BRANCH_NAME_OPTIONS['create']['format_string']}".
      LONG_DESC
      method_option :downcase, type: :boolean, aliases: '-d'
      method_option :separator, type: :string, aliases: '-s'
      method_option :format_string, type: :string, aliases: '-x'
      method_option :project, type: :boolean, aliases: '-p'
      method_option :project_location, type: :string, aliases: '-l'
      method_option :project_files, type: :array, aliases: '-f'
      method_option :interactive, type: :boolean, optional: true, aliases: '-i'

      def create(ticket_description, ticket = nil) # rubocop:disable Metrics/MethodLength
        original_options, altered_options = init_options_for! command: :create
        self.options = altered_options
        branch_name = BranchNameService.new(description: ticket_description, ticket: ticket, options: options).call
        say "Branch name: \"#{branch_name}\"", :cyan
        say "Branch name \"#{branch_name}\" has been copied to the clipboard!", SUCCESS if copy_to_clipboard branch_name
        if original_options[:interactive] && !options[:project]
          say 'Ignored: -i is only used with projects (-p).',
            WARNING
        end
        interactive_default = options['interactive']
        options[:interactive] = interactive_default if original_options[:interactive].nil?

        if options[:project]
          project_folder_name = validate_and_create_project_folder_name_from! branch_name
          if options[:interactive]
            project_folder = project_folder_for branch_name
            unless yes? "Create project for branch \"#{branch_name}\" " \
                        "in folder \"#{project_folder}\" (y/n)?", :cyan
              say 'Aborted.', ABORTED
              return
            end
          end

          say "Project folder name: \"#{project_folder_name}\"", :cyan
          create_project!(project_folder_name)
        end
      rescue ArgumentError => e
        say_error e.message, ERROR
        exit 1
      end

      desc 'config SUBCOMMAND', 'Manages config files for this gem'
      subcommand :config, Branch::Name::Subcommands::Config

      desc '--version, -v', 'Displays this gem version'
      def version
        say Branch::Name::VERSION
      end

      private

      def validate_and_create_project_folder_name_from!(branch_name)
        project_folder_name_from(branch_name) do |error|
          say_error error.message
          exit 1
        end
      end

      def init_options_for!(command:)
        options_array = []
        options_array << options.dup

        say "Options before config file merge: #{options}" if options[:debug]

        (load_options(defaults: DEFAULT_BRANCH_NAME_OPTIONS)[command.to_s] || {}).tap do |load_options|
          say "No options loaded from config file(s): #{load_options}" if options[:debug] && load_options.blank?
          say "Options loaded from config file(s): #{load_options}" if options[:debug]

          options_array << Thor::CoreExt::HashWithIndifferentAccess.new(load_options.merge(options))
          say "Options after config file merge: #{options_array.last}" if options_array.last[:debug]
        end

        options_array
      end
    end
  end
end
