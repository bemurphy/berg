require "admin/import"
require "admin/entities/post"
require "admin/posts/validation/form"
require "kleisli"

module Admin
  module Posts
    module Operations
      class Update
        include Admin::Import(
          "admin.persistence.repositories.posts",
        )

        include Dry::ResultMatcher.for(:call)

        def call(slug, attributes)
          validation = Validation::Form.(prepare_attributes(slug, attributes))

          if validation.success?
            posts.update_by_slug(slug, validation.output)
            Right(posts.by_slug(validation.output.fetch(:slug) { slug }))
          else
            Left(validation)
          end
        end

        private

        def prepare_attributes(slug, attributes)
          attributes.dup.tap do |attrs|
            # Only keep the slug for validation/update if it has been modified
            attrs.delete("slug") if (new_slug = attributes["slug"]) && new_slug == slug
          end
        end
      end
    end
  end
end
