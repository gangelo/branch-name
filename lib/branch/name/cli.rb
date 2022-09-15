# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/object/blank'
require 'bundler'
require 'colorize'
require 'thor'
require_relative 'version'

module Branch
  module Name
    #
    # The `branch-name` command.
    #
    class CLI < ::Thor
      class << self
        def exit_on_failure?
          false
        end
      end

      default_task :create
      map '--version': :version

      desc 'create [TICKET, DESCRIPTION]', 'Formulate a branch name based on a ticket and description'
      method_option :downcase, type: :boolean, aliases: '-d'
      method_option :project, type: :boolean, aliases: '-p'
      method_option :separator, type: :string, aliases: '-s', default: '_'

      def create(ticket, ticket_description)
        if ticket.blank? && ticket_description.blank?
          say_error 'ticket and/or ticket_description is required', :red
          exit 1
        end

        branch_name = "#{ticket} #{ticket_description}".strip
        branch_name = branch_name.split.join options[:separator]
        branch_name = branch_name.downcase if options[:downcase]
        branch_name = branch_name.tr('_', '-') if options[:separator] == '-'
        branch_name = branch_name.tr('-', '_') if options[:separator] == '_'

        puts "branch name: #{branch_name}".cyan
      end
    end
  end
end
