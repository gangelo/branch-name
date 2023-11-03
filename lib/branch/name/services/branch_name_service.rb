# frozen_string_literal: true

require_relative '../colorizable'
require_relative '../normalizable'

module Branch
  module Name
    class BranchNameService
      include Colorizable
      include Normalizable

      def initialize(description:, ticket: nil, options: {})
        @description  = description
        @ticket       = ticket
        @options      = options
      end

      def call
        validate_description!
        @branch_name = normalize_branch_name!
        validate_banch_name!
        @branch_name
      end

      private

      attr_reader :options

      def normalize_branch_name!
        normalize_branch_name(@description, @ticket) do |error|
          raise ArgumentError, error.message
        end
      end

      def validate_description!
        return unless @description.blank?

        raise ArgumentError, 'description is required'
      end

      def validate_banch_name!
        return unless @branch_name.blank?

        raise ArgumentError, invalid_branch_name_message
      end

      def invalid_branch_name_message
        'the combination of description/ticket resulted in an empty branch name'
      end
    end
  end
end
