# frozen_string_literal: true

module Branch
  module Name
    module Nameable
      def normalize_branch_name(branch_name)
        branch_name.strip!
        branch_name = branch_name.split.join options[:separator]
        branch_name.downcase! if options[:downcase]
        branch_name.tr!('_', '-') if options[:separator] == '-'
        branch_name.tr!('-', '_') if options[:separator] == '_'
        branch_name.squeeze!('-') if options[:separator] == '-'
        branch_name.squeeze!('_') if options[:separator] == '_'
        branch_name
      end
    end
  end
end
