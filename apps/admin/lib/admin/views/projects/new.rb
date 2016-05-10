require "admin/import"
require "admin/view"
require "admin/projects/forms/create_form"

module Admin
  module Views
    module Projects
      class New < Admin::View
        include Admin::Import("admin.projects.forms.create_form")

        configure do |config|
          config.template = "projects/new"
        end

        def locals(options = {})
          super.merge(project_form: form_data(options[:validation]))
        end

        def form_data(validation)
          if validation
            create_form.build(validation, validation.messages)
          else
            create_form.build
          end
        end
      end
    end
  end
end
