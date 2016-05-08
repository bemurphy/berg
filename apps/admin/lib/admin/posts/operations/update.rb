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
          "admin.posts.slugify"
        )

        include Dry::ResultMatcher.for(:call)

        def call(slug, attributes)
          validation = Validation::Form.(attributes)

          if validation.success?
            posts.update(slug, prepare_attributes(slug, validation.output))
            Right(posts[slug])
          else
            Left(validation)
          end
        end

        private

        def prepare_attributes(slug, attributes)
          # Only update the slug if a slug is present in the attrs, and it's been modified
          if attributes[:slug] && attributes[:slug] != slug
            slug = slugify.(attributes[:slug], posts.method(:slug_exists?))
          end
          attributes.merge(
            slug: slug
          )
        end

        # def prepare_attributes(attributes)
        #   if attributes[:status] == "published"
        #     attributes.merge(
        #       published_at: DateTime.now
        #     )
        #   else
        #     attributes
        #   end
        # end
      end
    end
  end
end
