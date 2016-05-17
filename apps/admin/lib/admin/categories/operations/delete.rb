require "admin/import"
require "admin/entities/category"
require "admin/categories/validation/form"
require "kleisli"

module Admin
  module Categories
    module Operations
      class Delete
        include Admin::Import("admin.persistence.repositories.categories")

        include Dry::ResultMatcher.for(:call)

        def call(slug)
          categories.delete(slug)
        end

        private

        def prepare_attributes(attributes)
          attributes.merge(
            slug: slugify.(attributes[:name], categories.method(:slug_exists?))
          )
        end
      end
    end
  end
end
