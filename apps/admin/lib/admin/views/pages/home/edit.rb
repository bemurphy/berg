require "admin/import"
require "admin/pages/home/forms/edit_form"
require "admin/view"

module Admin
  module Views
    module Pages
      module Home
        class Edit < Admin::View
          include Admin::Import(
            "admin.persistence.repositories.home_page_featured_projects",
            "admin.persistence.repositories.projects",
            "admin.pages.home.forms.edit_form"
          )

          configure do |config|
            config.template = "pages/home/edit"
          end

          def locals(options = {})
            selected_home_page_featured_projects = home_page_featured_projects.all_project_ids

            page_validation = options[:page_validation]

            super.merge(
              page_form: page_form(selected_home_page_featured_projects, page_validation)
            )
          end

          private

          def page_form(projects_list, validation)
            if validation
              edit_form.build(validation, validation.messages)
            else
              edit_form.build(form_input(projects_list))
            end
          end

          def form_input(projects_list)
            {
              home_page_featured_projects: projects_list.map(&:project_id)
            }
          end
        end
      end
    end
  end
end
