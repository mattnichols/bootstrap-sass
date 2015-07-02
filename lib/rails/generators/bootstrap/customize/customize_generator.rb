require 'rails/generators/base'

module Bootstrap
  module Generators
    class CustomizeGenerator < ::Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..", "assets"))
      
      desc "Description:\n    Adds bootstrap-sass _variables.scss and _bootstrap-custom.scss to assets directory."
      def customize
        copy_file(File.join("stylesheets", "bootstrap", "_variables.scss"), File.join("app", "assets", "stylesheets", "_variables.scss"))
        
        copy_file(File.join("stylesheets", "_bootstrap.scss"), File.join("app", "assets", "stylesheets", "_bootstrap-custom.scss")) do |content|
          content.gsub!("bootstrap/variables", "variables")
          content
        end
        
        gsub_file(File.join("app", "assets", "stylesheets", "application.scss"), /^\s*@import\s*([\"\'])bootstrap[\"\']\s*;/, '@import \1bootstrap-custom\1;', *args)
        puts <<-HELP
        
=============================
== Bootstrap Customization ==
-----------------------------

To customize what parts of Bootstrap CSS is loaded, edit:
  #{File.join("app", "assets", "stylesheets", "_bootstrap-custom.scss")}

To change bootstrap scss variables, edit:
  #{File.join("app", "assets", "stylesheets", "_variables.scss")}

To use a generated theme _variables.scss (from https://bootswatch.com/ for example) do the following:

  * Replace #{File.join("app", "assets", "stylesheets", "_variables.scss")} with your new _variables.scss file.

    OR

  * Change the following line in _bootstrap-custom.scss

      @import "variables";

        To

      @import "path/to/your/theme/variables"

      *** NOTE: This MUST be done in your _bootstrap-custom.scss file - NOT your application.scss - otherwise the $bootstrap-sass-asset-helper variable will not be set correctly.

  * Edit the _variables.scss file and change the value assigned to $icon-font-path, as follows:

      $icon-font-path: if($bootstrap-sass-asset-helper, "bootstrap/", "../fonts/bootstrap/");

      *** NOTE: This must be done, otherwise, glyphicons may not load properly.


  ** See https://github.com/twbs/bootstrap-sass for more customization details
  
==

        HELP
      end
    end
  end
end