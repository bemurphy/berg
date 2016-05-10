require "admin/import"
require "admin/entities/post"
# require "admin/posts/validation/form"
require "kleisli"

module Admin
  module Tags
    module Operations
      class Create
        include Admin::Import(
          "admin.persistence.repositories.tags",
          "admin.tags.slugify"
        )

        include Dry::ResultMatcher.for(:call)

        def call(attributes)
          # validation = Validation::Form.(attributes)

          # if validation.success?
          post = Entities::Tag.new(tags.create(prepare_attributes(attributes)))
          #   Right(post)
          # else
          #   Left(validation)
          # end
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
