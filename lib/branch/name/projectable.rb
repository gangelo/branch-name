
require_relative 'locatable'

module Branch
  module Name
    module Projectable
      include Locatable

      def create_project!(branch_name)
        return unless options[:project]

        project = "#{options[:project_location]}/#{branch_name}"
        puts "Project \"#{project}\" with project files #{options[:project_files]} was created".green
      end
    end
  end
end
