# frozen_string_literal: true

module Branch
  module Name
    # Forces the default Thor task to be :help
    module TaskDefaultable
      class << self
        def included(base)
          base.default_command :help
        end
      end
    end
  end
end
