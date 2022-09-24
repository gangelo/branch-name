# frozen_string_literal: true

require 'os'

module Branch
  module Name
    module Clipable
      module_function

      def copy_to_clipboard(text)
        if OS.mac?
          copy_to_clipboard_macos text
          true
        elsif OS.windows?
          copy_to_clipboard_windows text
          true
        else
          false
        end
      end

      def copy_to_clipboard_macos(text)
        copy_to_clipboard_with(app: 'pbcopy', text: text)
      end

      def copy_to_clipboard_windows(text)
        copy_to_clipboard_with(app: 'clip', text: text)
      end

      def copy_to_clipboard_with(app:, text:)
        IO.popen(app, 'w') { |pipe| pipe.puts text }
      end
    end
  end
end
