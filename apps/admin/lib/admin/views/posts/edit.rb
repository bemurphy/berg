require "admin/import"
require "admin/view"
require "admin/posts/forms/edit_form"

module Admin
  module Views
    module Posts
      class Edit < Admin::View
        include Admin::Import(
          "admin.persistence.repositories.posts",
          "admin.persistence.repositories.tags",
          "admin.persistence.repositories.taggings",
          "admin.posts.forms.edit_form"
        )

        configure do |config|
          config.template = "posts/edit"
        end

        def locals(options = {})
          post = posts.by_slug(options[:slug])

          post_validation = options[:post_validation]

          super.merge(
            post: post,
            post_form: post_form(post, post_validation)
          )
        end

        private

        def post_form(post, validation)
          if validation
            edit_form.build(validation, validation.messages)
          else
            edit_form.build(form_input(post))
          end
        end

        def form_input(post)
          tags = post.post_tags
          post.to_h.merge(
            post_tags: tags.map(&:id)
          )
        end
      end
    end
  end
end
