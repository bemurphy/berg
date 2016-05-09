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
          validation = Validation::Form.(prepare_attributes_for_validation(slug, attributes))

          if validation.success?
            posts.update_by_slug(slug, prepare_attributes_for_update(validation.output))
            Right(posts.by_slug(validation.output.fetch(:slug) { slug }))
          else
            Left(validation)
          end
        end

        private

        def prepare_attributes_for_validation(slug, attributes)
          attributes.dup.tap do |attrs|
            # Only keep the slug for validation/update if it has been modified
            attrs.delete("slug") if (new_slug = attributes["slug"]) && new_slug == slug
          end
        end

        def prepare_attributes_for_update(attributes)
          if attributes[:status] == "published"
            attributes.merge(published_at: Time.now)
          else
            attributes
          end
        end
      end
    end
  end
end
