# frozen_string_literal: true

module Branch
  module Name
    module Normalizable
      NON_WORD_CHARS_REGEX = /[\W_]/

      def normalize_branch_name(ticket_description, ticket)
        normalized_ticket_description = normalize_ticket_description ticket_description
        return normalized_ticket_description if ticket.blank?

        normalized_ticket = normalize_ticket ticket
        "#{normalized_ticket}#{options[:separator]}#{normalized_ticket_description}"
      end

      private

      def normalize_ticket_description(ticket_description)
        normalize_token ticket_description
      end

      def normalize_ticket(ticket)
        ticket.split(NON_WORD_CHARS_REGEX).filter_map do |token|
          normalize_token(token)
        end.join(options[:separator])
      end

      def normalize_token(token)
        token = token.gsub(NON_WORD_CHARS_REGEX, ' ')
        token = token.strip
          .squeeze(' ')
          .split.join(options[:separator])
        token = token.squeeze(options[:separator])
        token = token.downcase if options[:downcase]
        token
      end
    end
  end
end
