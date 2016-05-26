require "admin/import"
require "kleisli"

module Admin
  module Pages
    module Home
      module Operations
        class Update
          include Admin::Import[
            "core.persistence.commands.update_home_page_featured_items"
          ]

          include Dry::ResultMatcher.for(:call)

          def call(attributes)
            validation = Validation::Form.(attributes)

            byebug

            if validation.success?
              home_page_featured_items = update_home_page_featured_items.(validation.output)
              Right(home_page_featured_items)
            else
              Left(validation)
            end
          end
        end
      end
    end
  end
end
