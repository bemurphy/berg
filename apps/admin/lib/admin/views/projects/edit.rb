require "admin/import"
require "admin/view"
require "admin/projects/forms/edit_form"

module Admin
  module Views
    module Projects
      class Edit < Admin::View
        include Admin::Import(
          "admin.persistence.repositories.projects",
          "admin.projects.forms.edit_form"
        )

        configure do |config|
          config.template = "projects/edit"
        end

        def locals(options = {})
          project = projects.by_slug(options.fetch(:slug))

          project_validation = options[:project_validation]

          super.merge(
            project: project,
            project_form: project_form(project, project_validation)
          )
        end

        private

        def project_form(project, validation)
          if validation
            edit_form.build(validation, validation.messages)
          else
            edit_form.build(project)
          end
        end
      end
    end
  end
end
