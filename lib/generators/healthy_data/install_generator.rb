require "rails/generators/active_record"

module HealthyData
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ActiveRecord::Generators::Migration
      source_root File.join(__dir__, "templates")

      def copy_templates
        template "healthy_data_initializer.rb", "config/initializers/healthy_data.rb"
        migration_template "active_record_migration.rb", "db/migrate/create_healthy_data_item_checks.rb", migration_version: migration_version
        puts "\nAlmost done. Please run:\n\n\t\trails db:migrate"
      end

      private

      def migration_version
        "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
      end

    end
  end
end
