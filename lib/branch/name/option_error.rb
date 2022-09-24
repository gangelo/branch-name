# frozen_string_literal: true

module Branch
  module Name
    class OptionError < StandardError
      attr_reader :command

      def initialize(msg, command)
        super(msg)

        @command = command
      end

      def message
        "ERROR: \"branch-name #{command}\" #{super}"
      end
    end
  end
end
