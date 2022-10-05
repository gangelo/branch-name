# frozen_string_literal: true

require_relative 'option_error'

module Branch
  module Name
    module Normalizable
      # The regex used to split ticket and ticket description tokens
      # to formulate a source control branch name.
      BRANCH_NAME_REGEX = %r{[^/\w\x20]|_}

      # The regex used to split ticket and ticket description tokens
      # to formulate a project folder based on the branch name formulated.
      PROJECT_FOLDER_REGEX = /[\W_]/

      # Acceptable project folder token separators. If options[:separator]
      # returns one of these acceptable values, it will be used; otherwise
      # DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR will be used.
      PROJECT_FOLDER_TOKEN_SEPARATORS = %w[- _].freeze

      # The default project folder token separator if options[:separator] is
      # not an acceptable project folder token separator
      # (i.e. PROJECT_FOLDER_TOKEN_SEPARATORS).
      DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR = PROJECT_FOLDER_TOKEN_SEPARATORS.first

      def normalize_branch_name(ticket_description, ticket)
        formatted_branch_name = format_string_or_default
        formatted_branch_name = formatted_branch_name.gsub('%t', ticket || '')
        formatted_branch_name = formatted_branch_name.gsub('%d', ticket_description)
        formatted_branch_name = formatted_branch_name.gsub('%u', Etc.getlogin)
        normalize_token formatted_branch_name, BRANCH_NAME_REGEX, options[:separator]
      rescue Branch::Name::OptionError => e
        raise unless block_given?

        yield e
      end

      # Returns a project folder name from a normalized branch name.
      # The location of the folder is not included; that is, the
      # folder returned is not fully qualified.
      def project_folder_name_from(normalized_branch_name)
        normalize_token normalized_branch_name, PROJECT_FOLDER_REGEX, project_folder_separator
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

      def normalize_token(token, regex, separator)
        token = token.gsub(regex, ' ')
        token = token.strip
          .squeeze(' ')
          .split.join(separator)
        token = token.squeeze(separator)
        token = token.downcase if options[:downcase]
        token
      end

      def project_folder_separator
        separator = options[:separator]
        return options[:separator] if PROJECT_FOLDER_TOKEN_SEPARATORS.include? separator

        DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR
      end
    end
  end
end
