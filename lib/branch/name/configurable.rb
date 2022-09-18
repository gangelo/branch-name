# frozen_string_literal: true

require 'colorize'
require 'fileutils'
require 'yaml'
require_relative 'locatable'

module Branch
  module Name
    module Configurable
      include Locatable

      CONFIG_FILENAME = '.branch-nameconfig'
      DEFAULT_BRANCH_NAME_OPTIONS = {
        create: {
          'downcase': false,
          'separator': '_',
          'project_files': false
        }
      }

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

      private

      def create_config_file(config_file)
        folder = File.dirname(config_file)
        unless Dir.exist?(folder)
          puts "Destination folder for configuration file (#{folder}) does not exist".red
          return false
        end

        if File.exist?(config_file)
          puts "Configuration file (#{config_file}) already exists".yellow
          return false
        end

        File.open(config_file, 'w') { |file| file.write(DEFAULT_BRANCH_NAME_OPTIONS.to_yaml) }
        puts "Configuration file (#{config_file}) created".green

        true
      end
    end
  end
end
