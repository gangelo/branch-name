# frozen_string_literal: true

module Branch
  module Name
    module Subcommands
      # This module fixes a bug in Thor that prohibits help for nested
      # subcommands from displaying help properly. Nested subcommands fail
      # to display their subcommand ancestor command name. This fixes that
      # bug.
      module Nestable
        class << self
          def included(base)
            base.extend ClassMethods
          end
        end

        module ClassMethods
          def ancestor_name
            raise NotImplementedError
          end

          # Thor override
          # rubocop:disable Style/GlobalVars
          # rubocop:disable Lint/UnusedMethodArgument
          # rubocop:disable Style/OptionalBooleanParameter
          def banner(command, namespace = nil, subcommand = false)
            command.formatted_usage(self, $thor_runner, subcommand).split("\n").map do |_formatted_usage|
              "#{basename} #{@help_override[command.usage]}"
            end.join("\n")
          end
          # rubocop:enable Style/GlobalVars
          # rubocop:enable Lint/UnusedMethodArgument
          # rubocop:enable Style/OptionalBooleanParameter

          def help_override(help_string)
            if @usage.blank?
              raise 'Thor.desc must be called for the command that should ' \
                    "be associated with \"#{help_string}\" prior to calling " \
                    '.help_override'
            end

            @help_override = {} unless defined? @help_override
            @help_override[@usage] = help_string
          end
        end
      end
    end
  end
end
