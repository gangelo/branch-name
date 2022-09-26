# frozen_string_literal: true

require_relative 'help_nestable'

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
            base.include HelpNestable
          end
        end

        module ClassMethods
          def ascestor_name
            raise NotImplementedError
          end

          # Thor override
          def banner(command, _namespace = nil, subcommand = false)
            command.formatted_usage(self, $thor_runner, subcommand).split("\n").map do |_formatted_usage|
              command_name = command.name.to_sym
              "#{basename} #{@subcommand_help_override[command.usage]}"
            end.join("\n")
          end

          def subcommand_help_override(help_string)
            raise "Thor.desc must be called for \"#{help_string}\" " \
              'prior to calling .subcommand_help_override' if @usage.blank?

            @subcommand_help_override = {} unless defined? @subcommand_help_override
            @subcommand_help_override[@usage] = help_string
          end
        end
      end
    end
  end
end
