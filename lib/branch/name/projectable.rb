# frozen_string_literal: true

require 'fileutils'
require_relative 'locatable'

module Branch
  module Name
    module Projectable
      include Locatable

      def create_project!(branch_name)
        raise 'options[:project] is false' unless options[:project]

        project_folder = project_folder_for branch_name

        if Dir.exist? project_folder
          puts "Project folder \"#{project_folder}\" already exists"
          create_project_files!(project_folder)
          return
        end

        FileUtils.mkdir_p(project_folder)
        create_project_files!(project_folder)

        project_files = options[:project_files]
        if project_files.blank?
          puts "Project folder \"#{project_folder}\" was created.".green
        else
          puts "Project folder \"#{project_folder}\" was created with project files:".green
          project_files.each do |project_file|
            puts "- #{project_file}".green
          end
        end
      end

      def create_project_files!(project_folder)
        raise 'options[:project] is false' unless options[:project]
        raise "Project folder \"#{project_folder}\" does not exist" unless Dir.exist? project_folder

        project_files = options[:project_files]

        return if project_files.blank?

        project_files.each do |project_file|
          full_file_name = File.join(project_folder, project_file)

          next if File.exist? full_file_name

          FileUtils.touch full_file_name
          puts "Created project file \"#{full_file_name}\"" if options[:verbose]
        end
      end

      def project_folder_for(branch_name)
        project_location = Time.new.strftime(options[:project_location])
        "#{project_location}/#{branch_name}"
      end
    end
  end
end
