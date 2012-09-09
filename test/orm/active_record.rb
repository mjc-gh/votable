ActiveRecord::Base.logger = Logger.new(nil)
ActiveRecord::Migration.verbose = false

ActiveRecord::Base.establish_connection(Rails.application.config.database_configuration[ENV['RAILS_ENV']])
ActiveRecord::Migrator.migrate(File.expand_path("../../rails_app/db/migrate/", __FILE__))

