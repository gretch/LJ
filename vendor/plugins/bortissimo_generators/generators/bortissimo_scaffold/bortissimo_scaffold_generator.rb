class BortissimoScaffoldGenerator < RspecScaffoldGenerator
  def manifest
    record do |m|

      # Check for class naming collisions.
      m.class_collisions(controller_class_path, "#{controller_class_name}Controller", "#{controller_class_name}Helper")
      m.class_collisions(class_path, "#{class_name}")

      # Controller, helper, views, locales, and spec directories.
      m.directory(File.join('app/models', class_path))
      m.directory(File.join('app/controllers', controller_class_path))
      m.directory(File.join('app/helpers', controller_class_path))
      m.directory(File.join('app/views', controller_class_path, controller_file_name))

      m.directory(File.join('config/locales', class_path))

      m.directory(File.join('spec/controllers', controller_class_path))
      m.directory(File.join('spec/routing', controller_class_path))
      m.directory(File.join('spec/models', class_path))
      m.directory(File.join('spec/helpers', class_path))
      m.directory File.join('spec/fixtures', class_path)
      m.directory File.join('spec/factories', class_path)
      m.directory File.join('spec/views', controller_class_path, controller_file_name)

      # Controller spec, class, and helper.
      m.template 'rspec_scaffold:routing_spec.rb',
        File.join('spec/routing', controller_class_path, "#{controller_file_name}_routing_spec.rb")

      m.template 'bortissimo_scaffold:controller_spec.rb',
        File.join('spec/controllers', controller_class_path, "#{controller_file_name}_controller_spec.rb")

      m.template "bortissimo_scaffold:controller.rb",
        File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")

      m.template 'rspec_scaffold:helper_spec.rb',
        File.join('spec/helpers', class_path, "#{controller_file_name}_helper_spec.rb")

      m.template "scaffold:helper.rb",
        File.join('app/helpers', controller_class_path, "#{controller_file_name}_helper.rb")

      for action in scaffold_views
        m.template(
          "bortissimo_scaffold:view_#{action}.#{@default_file_extension}",
          File.join('app/views', controller_class_path, controller_file_name, "#{action}.#{default_file_extension}")
        )
      end

      # Model class, unit test, and fixtures.
      m.template 'model:model.rb',      File.join('app/models', class_path, "#{file_name}.rb")
      m.template 'model:fixtures.yml',  File.join('spec/fixtures', class_path, "#{table_name}.yml")
      m.template 'bortissimo_scaffold:factory.rb',    File.join('spec/factories', class_path, "#{file_name}_factory.rb")
      m.template 'bortissimo_scaffold:model_spec.rb', File.join('spec/models', class_path, "#{file_name}_spec.rb")

      # View specs
      m.template "rspec_scaffold:edit_erb_spec.rb",
        File.join('spec/views', controller_class_path, controller_file_name, "edit.#{default_file_extension}_spec.rb")
      m.template "bortissimo_scaffold:index_erb_spec.rb",
        File.join('spec/views', controller_class_path, controller_file_name, "index.#{default_file_extension}_spec.rb")
      m.template "rspec_scaffold:new_erb_spec.rb",
        File.join('spec/views', controller_class_path, controller_file_name, "new.#{default_file_extension}_spec.rb")
      m.template "rspec_scaffold:show_erb_spec.rb",
        File.join('spec/views', controller_class_path, controller_file_name, "show.#{default_file_extension}_spec.rb")

      # Locale.
      m.template "bortissimo_scaffold:locale_en.yml", File.join('config/locales', class_path, "en_#{file_name}.yml")

      unless options[:skip_migration]
        m.migration_template(
          'model:migration.rb', 'db/migrate',
          :assigns => {
            :migration_name => "Create#{class_name.pluralize.gsub(/::/, '')}",
            :attributes     => attributes
          },
          :migration_file_name => "create_#{file_path.gsub(/\//, '_').pluralize}"
        )
      end

      m.route_resources controller_file_name

    end
  end

  protected
  include ActionView::Helpers::TextHelper
    # Override with your own usage banner.
    def banner
      "Usage: #{$0} rspec_scaffold ModelName [field:type field:type]"
    end

    def scaffold_views
      %w[ index show new edit _form ]
    end
end
