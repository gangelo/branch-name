# frozen_string_literal: true

require 'colorize'
require 'fileutils'
require 'yaml'
require_relative 'locatable'

module Branch
  module Name
    module Configurable
      include Locatable

      CONFIG_FILENAME = '.branch-name'
      # rubocop:disable Style/StringHashKeys - YAML writing/loading necessitates this
      DEFAULT_BRANCH_NAME_OPTIONS = {
        'create' => {
          'downcase' => false,
          'separator' => '_',
          'project' => false,
          'project_location' => Locatable.project_folder,
          'project_files' => %w[scratch.rb readme.txt]
        }
      }.freeze
      # rubocop:enable Style/StringHashKeys

      module_function

      def global_config_file
        File.join(global_folder, CONFIG_FILENAME)
      end

      def local_config_file
        File.join(local_folder, CONFIG_FILENAME)
      end

      def system_config_file
        File.join(system_folder, CONFIG_FILENAME)
      end

      def global_config_file?
        File.exist? global_config_file
      end

      def local_config_file?
        File.exist? local_config_file
      end

      def system_config_file?
        File.exist? system_config_file
      end

      def create_global_config_file!
        create_config_file global_config_file
      end

      def create_local_config_file!
        create_config_file local_config_file
      end

      def create_system_config_file!
        create_config_file system_config_file
      end

      def delete_global_config_file!
        delete_config_file global_config_file
      end

      def delete_local_config_file!
        delete_config_file local_config_file
      end

      def delete_system_config_file!
        delete_config_file system_config_file
      end

      private

      def create_config_file(config_file)
        folder = File.dirname(config_file)
        unless Dir.exist?(folder)
          say "Destination folder for configuration file (#{folder}) does not exist".red
          return false
        end

        if File.exist?(config_file)
          puts "Configuration file (#{config_file}) already exists".yellow
          return false
        end

        File.write(config_file, DEFAULT_BRANCH_NAME_OPTIONS.to_yaml)
        puts "Configuration file (#{config_file}) created".green

        true
      end

      def delete_config_file(config_file)
        unless File.exist?(config_file)
          puts "Configuration file (#{config_file}) does not exist".yellow
          return false
        end

        File.delete config_file
        puts "Configuration file (#{config_file}) deleted".green

        true
      end
    end
  end
end
