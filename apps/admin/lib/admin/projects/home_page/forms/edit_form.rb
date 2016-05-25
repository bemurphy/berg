require "berg/form"

module Admin
  module Projects
    module HomePage
      module Forms
        class EditForm < Berg::Form
          include Admin::Import[
            "admin.persistence.repositories.projects",
            "admin.persistence.repositories.home_page_featured_projects"
          ]

          prefix :home_page_featured_project

          define do
          end
        end
      end
    end
  end
end
