require "admin/import"
require "admin/entities/project"
require "admin/projects/home_page/validation/form"
require "kleisli"

module Admin
  module Projects
    module HomePage
      module Operations
        class Create
          include Admin::Import(
            "admin.persistence.repositories.home_page_featured_projects"
          )

          include Dry::ResultMatcher.for(:call)

          def call(attributes)
            validation = Validation::Form.(attributes)

            if validation.success?
              home_page_featured_project = Entities::HomePageFeaturedProject.new(home_page_featured_projects.create(validation.output))
              Right(home_page_featured_project)
            else
              Left(validation)
            end
          end
        end
      end
    end
  end
end
