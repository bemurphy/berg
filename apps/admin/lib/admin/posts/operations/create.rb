require "admin/import"
require "admin/entities/post"
require "admin/posts/validation/form"
require "kleisli"

module Admin
  module Posts
    module Operations
      class Create
        include Admin::Import(
          "admin.persistence.repositories.posts"
        )

        include Dry::ResultMatcher.for(:call)

        def call(author, attributes)
          validation = Validation::Form.(attributes)

          if validation.success?
            post = Entities::Post.new(posts.create(prepare_attributes(author, validation.output)))
            Right(post)
          else
            Left(validation)
          end
        end

        private

        def prepare_attributes(author, attributes)
          attributes.merge(
            author_id: author.id
          )
        end
      end
    end
  end
end
