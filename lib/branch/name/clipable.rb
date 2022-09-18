# frozen_string_literal: true

module Branch
  module Name
    module Clipable
      module_function

      def copy_to_clipboard(text)
        if /darwin/.match?(RUBY_PLATFORM)
          IO.popen('pbcopy', 'w') { |pipe| pipe.puts text }
          true
        end
      end
    end
  end
end
