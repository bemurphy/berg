require "berg/form"

module Admin
  module Pages
    module Home
      module Forms
        class EditForm < Berg::Form
          include Admin::Import[
            "admin.persistence.repositories.projects"
          ]

          prefix :page

          define do
            multi_selection_field :home_page_featured_projects,
              label: "Featured Projects",
              selector_label: "Choose projects",
              options: dep(:projects_list)
          end

          def projects_list
            projects.all_projects.to_a.map { |project|
              {
                id: project.id,
                label: project.title
              }
            }
          end
        end
      end
    end
  end
end
