require "admin/import"
require "admin/entities/post"
require "kleisli"

module Admin
  module Tags
    module Operations
      class Create
        include Admin::Import(
          "admin.persistence.repositories.tags",
          "admin.slugify"
        )

        include Dry::ResultMatcher.for(:call)

        def call(attributes)
          tag = Entities::Tag.new(tags.create(prepare_attributes(attributes)))
          Right(tag)
        end

        private

        def prepare_attributes(attributes)
          attributes.merge(
            slug: slugify.(attributes[:name], tags.method(:slug_exists?))
          )
        end
      end
    end
  end
end
