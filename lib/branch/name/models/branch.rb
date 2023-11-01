# frozen_string_literal: true

require 'active_model'

module Branch
  module Name
    module Models
      attr_reader :description, :ticket

      class Branch
        include ActiveModel::Model

        attr_accessor :description, :ticket

        validates :description, presence: true

        def initialize(description:, ticket: nil, options: {})
          @description  = description
          @ticket       = ticket
          @options      = options

          super description: description, ticket: ticket
        end

        def branch_name
          ''
        end
      end
    end
  end
end
