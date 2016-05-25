require "admin/import"
require "kleisli"
require "types"

module Admin
  module Pages
    module Home
      module Operations
        class Update
          include Admin::Import(
            "core.persistence.commands.update_home_page_featured_projects"
          )

          include Dry::ResultMatcher.for(:call)

          def call(attributes)
            validation = Validation::Form.(attributes)

            if validation.success?
              home_page_featured_projects = update_home_page_featured_projects.(validation.output)
              Right(home_page_featured_projects)
            else
              Left(validation)
            end
          end
        end
      end
    end
  end
end
