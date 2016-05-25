require "admin/import"
require "admin/view"
require "admin/projects/forms/create_form"

module Admin
  module Views
    module Projects
      module HomePage
        class New < Admin::View
          include Admin::Import("admin.projects.home_page.forms.create_form")

          configure do |config|
            config.template = "projects/home_page/new"
          end

          def locals(options = {})
            super.merge(home_page_featured_project_form: form_data(options[:validation]))
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
end
