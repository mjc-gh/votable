require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class VotableGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_migration
        migration_template 'migration.rb', "db/migrate/votable_create_#{table_name}.rb"
      end

      def generate_model
        invoke 'active_record:model', [name], :migration => false
      end

      def inject_votable_content
        model_path = File.join('app', 'models', "#{file_path}.rb")

        class_path = class_name.to_s.split("::")
        injected_content = "include Votable::JoinVote"

        inject_into_class model_path, class_path.last, injected_content
      end
    end
  end
end
