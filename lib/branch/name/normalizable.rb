# frozen_string_literal: true

require_relative 'option_error'

module Branch
  module Name
    module Normalizable
      NON_WORD_CHARS_REGEX = /[\W_]/

      def normalize_branch_name(ticket_description, ticket)
        formatted_branch_name = format_string_or_default
        formatted_branch_name = formatted_branch_name.gsub('%t', ticket || '')
        formatted_branch_name = formatted_branch_name.gsub('%d', ticket_description)
        formatted_branch_name = normalize_token formatted_branch_name
      rescue Branch::Name::OptionError => e
        raise unless block_given?

        yield e
      end

      private

      def format_string_or_default
        format_string = options[:format_string].presence ||
                        Configurable::DEFAULT_BRANCH_NAME_OPTIONS['create']['format_string']
        unless %w[%t %d].all? { |o| format_string.include?(o) }
          raise Branch::Name::OptionError.new(
            'was called having argument [-x/--format-string] ' \
            'which did not contain %t and %d format placeholders',
            current_command_chain.first
          )
        end

        format_string
      end

      def normalize_ticket_description(ticket_description)
        normalize_token ticket_description
      end

      def normalize_ticket(ticket)
        return if ticket.blank?

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
