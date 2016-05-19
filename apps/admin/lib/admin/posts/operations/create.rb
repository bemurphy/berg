require "admin/import"
require "admin/entities/post"
require "admin/posts/validation/form"
require "kleisli"

module Admin
  module Posts
    module Operations
      class Create
        include Admin::Import(
          "admin.persistence.repositories.posts",
          "core.persistence.commands.create_post",
          "admin.slugify",
          "admin.persistence.post_color_picker",
        )

        include Dry::ResultMatcher.for(:call)

        def call(attributes)
          validation = Validation::Form.(attributes)

          if validation.success?
            post = Admin::Entities::Post.new(create_post.(prepare_attributes(validation.output)))
            Right(post)
          else
            Left(validation)
          end
        end

        private

        def prepare_attributes(attributes)
          attributes.merge(
            slug: slugify.(attributes[:title], posts.method(:slug_exists?)),
            color: post_color_picker.()
          )
        end
      end
    end
  end
end
