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
          def base_usage
            raise NotImplementedError
          end

          # Thor override
          # rubocop:disable Style/OptionHash
          def desc(usage, description, options = {})
            super "#{base_usage} #{usage} ", description, options
          end
          # rubocop:enable Style/OptionHash

          # Thor override
          # rubocop:disable Style/GlobalVars
          # rubocop:disable Lint/UnusedMethodArgument
          # rubocop:disable Style/OptionalBooleanParameter
          def banner(command, namespace = nil, subcommand = false)
            command.formatted_usage(self, $thor_runner, subcommand).split("\n").map do |_formatted_usage|
              "#{basename} #{command.usage}"
            end.join("\n")
          end
          # rubocop:enable Style/GlobalVars
          # rubocop:enable Lint/UnusedMethodArgument
          # rubocop:enable Style/OptionalBooleanParameter
        end
      end
    end
  end
end
