require "admin/import"
require "admin/entities/category"
require "admin/categories/validation/form"
require "kleisli"

module Admin
  module Categories
    module Operations
      class Update
        include Admin::Import(
          "admin.persistence.repositories.categories"
        )

        include Dry::ResultMatcher.for(:call)

        def call(slug, attributes)
          validation = Validation::Form.(prepare_attributes(slug, attributes))

          if validation.success?
            categories.update(slug, validation.output)
            Right(categories.by_slug(validation.output.fetch(:slug) { slug }))
          else
            Left(validation)
          end
        end

        private

        def prepare_attributes(slug, attributes)
          attributes.merge(
            previous_slug: slug
          )
        end
      end
    end
  end
end
