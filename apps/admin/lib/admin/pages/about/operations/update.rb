require "admin/import"
require "kleisli"
require "types"

module Admin
  module Pages
    module About
      module Operations
        class Update
          include Admin::Import(
            "core.persistence.commands.update_about_page_people"
          )

          include Dry::ResultMatcher.for(:call)

          def call(attributes)
            validation = Validation::Form.(attributes)

            if validation.success?
              about_page_people = update_about_page_people.(validation.output)
              Right(about_page_people)
            else
              Left(validation)
            end
          end
        end
      end
    end
  end
end
