# frozen_string_literal: true

require 'erb'
require 'yaml'
require_relative 'configurable'

module Branch
  module Name
    module Loadable
      include Configurable

      def load_options(defaults: {})
        options = {}

        options.merge!(load_config(global_config_file))
        options.merge!(load_config(local_config_file))

        options.presence || defaults
      end

      def load_config(config_file)
        return {} unless File.exist? config_file

        yaml_options = File.read(config_file)
        YAML.safe_load ERB.new(yaml_options).result
      end
    end
  end
end
