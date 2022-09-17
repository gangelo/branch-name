# frozen_string_literal: true

require 'colorize'
require_relative 'locatable'

module Branch
  module Name
    module Configurable
      include Locatable

      CONFIG_FILENAME = '.branch-nameconfig'

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
        Dir.exist? global_config_file
      end

      def local_config_file?
        Dir.exist? local_config_file
      end

      def system_config_file?
        Dir.exist? system_config_file
      end

      def create_global_config_file!
        return false if Dir.exist? global_config_file

        Dir.mkdir(global_config_file) == 0
      end

      def create_local_config_file!
        return false if Dir.exist? local_config_file

        Dir.mkdir(local_config_file) == 0
      end

      def create_system_config_file!
        return false if Dir.exist? system_config_file

        Dir.mkdir(system_config_file) == 0
      end
    end
  end
end
