require "admin/import"
require "admin/entities/post"
require "admin/posts/validation/form"
require "kleisli"

module Admin
  module Posts
    module Operations
      class Update
        include Admin::Import(
          "admin.persistence.repositories.posts"
        )

        include Dry::ResultMatcher.for(:call)

        def call(id, attributes)
          validation = Validation::Form.(attributes)

          if validation.success?
            posts.update(id, prepare_attributes(validation.output))
            Right(posts[id])
          else
            Left(validation)
          end
        end

        private

        def prepare_attributes(attributes)
          if attributes[:status] == "published"
            attributes.merge(
              published_at: DateTime.now
            )
          else
            attributes
          end
        end
      end
    end
  end
end
