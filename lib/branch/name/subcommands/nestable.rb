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
          def subcommand_help_map
            raise NotImplementedError
          end

          def banner(command, namespace = nil, subcommand = false)
            command.formatted_usage(self, $thor_runner, subcommand).split("\n").map do |formatted_usage|
              command_name = command.name.to_sym
              require 'pry-byebug'
              #binding.pry
              "#{basename} #{subcommand_help_map[command_name]}"
            end.join("\n")
          end
        end
      end
    end
  end
end
