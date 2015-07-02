require 'rails/generators/base'

module Bootstrap
  module Generators
    class ResetGenerator < ::Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..", "assets"))
      
      desc "Description:\n    Removes customization files _variables.scss and _bootstrap-custom.scss from assets directory."
      def reset
        remove_file(File.join("app", "assets", "stylesheets", "_variables.scss"))
        remove_file(File.join("app", "assets", "stylesheets", "_bootstrap-custom.scss"))
        gsub_file(File.join("app", "assets", "stylesheets", "application.scss"), /^\s*@import\s*([\"\'])bootstrap-custom[\"\']\s*;/, '@import \1bootstrap\1;', *args)
      end
    end
  end
end