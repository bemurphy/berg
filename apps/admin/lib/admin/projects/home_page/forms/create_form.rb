require "berg/form"

module Admin
  module Projects
    module HomePage
      module Forms
        class CreateForm < Berg::Form
          include Admin::Import[
            "admin.persistence.repositories.projects",
            "admin.persistence.repositories.home_page_featured_projects"
          ]

          prefix :home_page_featured_project

          define do
            selection_field :project_id, label: "Project", options: dep(:project_list)
          end

          def project_list
            projects.listing.to_a.map { |project| { id: project.id, label: project.title } }
          end
        end
      end
    end
  end
end
