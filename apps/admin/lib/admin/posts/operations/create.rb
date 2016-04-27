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

        def call(attributes)
          validation = Validation::Form.(attributes)

          if validation.messages.any?
            Left(validation.messages)
          else
            post = Entities::Post.new(posts.create(validation.output))
            Right(post)
          end
        end
      end
    end
  end
end
