module Votable
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc 'Create Votable config/initializer.'

      def create_initializer
        template('config.rb', 'config/initializers/votable.rb').inspect
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
