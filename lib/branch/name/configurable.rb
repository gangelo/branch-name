# frozen_string_literal: true

require 'colorize'
require 'fileutils'
require 'yaml'
require_relative 'colorizable'
require_relative 'locatable'

module Branch
  module Name
    module Configurable
      include Colorizable
      include Locatable

      CONFIG_FILENAME = '.branch-name'

      # rubocop:disable Style/StringHashKeys - YAML writing/loading necessitates this
      DEFAULT_BRANCH_NAME_OPTIONS = {
        'create' => {
          'downcase' => false,
          'separator' => '_',
          'format_string' => '%t %d',
          'project' => false,
          'project_location' => "#{Locatable.project_folder}/branch-name/projects/%Y/%m (%B)",
          'project_files' => %w[readme.txt scratch.rb snippets.rb],
          'interactive' => true
        }
      }.freeze
      # rubocop:enable Style/StringHashKeys

      def global_config_file
        File.join(Locatable.global_folder, CONFIG_FILENAME)
      end

      def local_config_file
        File.join(Locatable.local_folder, CONFIG_FILENAME)
      end

      def global_config_file?
        File.exist? global_config_file
      end

      def local_config_file?
        File.exist? local_config_file
      end

      def create_global_config_file!
        create_options = DEFAULT_BRANCH_NAME_OPTIONS
        yield create_options if block_given?
        create_config_file global_config_file, create_options: create_options
        print_global_config_file
      end

      def create_local_config_file!
        create_options = DEFAULT_BRANCH_NAME_OPTIONS
        yield create_options if block_given?
        create_config_file local_config_file, create_options: create_options
        print_local_config_file
      end

      def delete_global_config_file!
        delete_config_file global_config_file
      end

      def delete_local_config_file!
        delete_config_file local_config_file
      end

      def print_global_config_file
        config_file = global_config_file
        if global_config_file?
          say "Global config file (#{config_file}) contents:", SUCCESS
          print_config_file config_file
        else
          say "Global config file (#{config_file}) does not exist.", WARNING
        end
      end

      def print_local_config_file
        config_file = local_config_file
        if local_config_file?
          say "Local config file (#{config_file}) contents:", SUCCESS
          print_config_file config_file
        else
          say "Local config file (#{config_file}) does not exist.", WARNING
        end
      end

      def create_config_file(config_file, create_options:)
        folder = File.dirname(config_file)
        unless Dir.exist?(folder)
          say "Destination folder for configuration file (#{folder}) does not exist", ERROR
          return false
        end

        if File.exist?(config_file)
          say "Configuration file (#{config_file}) already exists", WARNING
          return false
        end

        File.write(config_file, create_options.to_yaml)
        say "Configuration file (#{config_file}) created.", SUCCESS

        true
      end

      private

      def delete_config_file(config_file)
        unless File.exist?(config_file)
          say "Configuration file (#{config_file}) does not exist", WARNING
          return false
        end

        File.delete config_file
        say "Configuration file (#{config_file}) deleted", SUCCESS

        true
      end

      def print_config_file(config_file)
        hash = YAML.safe_load(File.open(config_file))
        say hash.to_yaml.gsub("\n-", "\n\n-"), SUCCESS
      end
    end
  end
end
