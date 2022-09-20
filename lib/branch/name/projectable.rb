# frozen_string_literal: true

require 'fileutils'
require_relative 'locatable'

module Branch
  module Name
    module Projectable
      include Locatable

      def create_project!(branch_name)
        raise 'options[:project] is false' unless options[:project]

        project_folder = "#{options[:project_location]}/#{branch_name}"

        if Dir.exist? project_folder
          puts "Project folder \"#{project_folder}\" already exists"
          create_project_files!(project_folder)
          return
        end

        Dir.mkdir project_folder
        create_project_files!(project_folder)

        puts "Project folder \"#{project_folder}\" with project files #{options[:project_files]} was created".green
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
          puts "Created project file \"#{full_file_name}\""
        end
      end
    end
  end
end
