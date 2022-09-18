# frozen_string_literal: true

require 'colorize'
require 'pathname'

module Branch
  module Name
    module Locatable
      module_function

      def home_folder
        Dir.home
      end
      alias global_folder home_folder
      singleton_class.alias_method :global_folder, :home_folder

      def local_folder
        Dir.pwd
      end

      def system_folder
        system_folder = Pathname.new('/')
        unless system_folder.exist? && system_folder.directory?
          puts "WARNING: system folder #{system_folder} does not exist, " \
               "using global folder instead (#{global_folder})".red

          return global_folder
        end
        system_folder.to_s
      end

      def project_folder(options: {})
        return home_folder if options.blank?

        home_folder
      end

      def system_folder_equals_global_folder?
        syetem_folder == global_folder
      end

      def temp_folder
        Dir.tmpdir
      end
    end
  end
end
