require "admin/import"
require "admin/entities/project"
require "admin/projects/home_page/validation/form"
require "kleisli"

module Admin
  module Projects
    module HomePage
      module Operations
        class Update
          include Admin::Import(
            "admin.persistence.repositories.home_page_featured_projects"
          )

          include Dry::ResultMatcher.for(:call)

          def call(id, attributes)
            validation = Validation::Form.(id, attributes)

            if validation.success?
              home_page_featured_projects.update_by_id(id, validation.output)
              Right(home_page_featured_projects.by_id(validation.output.fetch(:id) { id }))
            else
              Left(validation)
            end
          end
        end
      end
    end
  end
end
