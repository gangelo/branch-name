# frozen_string_literal: true

module Branch
  module Name
    module Subcommands
      # This module helps fix a bug in Thor that prohibits help for nested
      # subcommands from displaying help properly. Nested subcommands fail
      # to display their subcommand ancestor command name. This fixes that
      # bug. This module is used in conjunction with the Nestable module.
      module HelpNestable
        class << self
          def included(base)
            # Thor override
            base.desc 'help [COMMAND]', 'Describe available commands or one specific command'
            base.subcommand_help_override "config init help [SUBCOMMAND]"
            def help(command = nil, subcommand = false)
              super
            end
          end
        end
      end
    end
  end
end
