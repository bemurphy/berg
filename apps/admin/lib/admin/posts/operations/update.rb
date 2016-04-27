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

        def call(post_id, attributes)
          validation = Validation::Form.(attributes)

          if validation.messages.any?
            Left(validation.messages)
          else
            posts.update(post_id, validation.output)
            Right(posts[post_id])
          end
        end
      end
    end
  end
end
