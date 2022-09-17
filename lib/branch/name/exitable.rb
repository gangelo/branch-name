module Branch
  module Name
    module Exitable
      def included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def exit_on_failure?
          false
        end
      end
    end
  end
end
