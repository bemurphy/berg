require "admin/import"
require "admin/entities/post"
require "kleisli"

module Admin
  module Categories
    module Operations
      class Create
        include Admin::Import(
          "admin.persistence.repositories.categories",
          "admin.slugify"
        )

        include Dry::ResultMatcher.for(:call)

        def call(attributes)
          category = Entities::Category.new(categories.create(prepare_attributes(attributes)))
          Right(category)
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
