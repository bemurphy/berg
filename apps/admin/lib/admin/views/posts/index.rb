require "admin/import"
require "admin/view"

module Admin
  module Views
    module Posts
      class Index < Admin::View
        include Admin::Import("admin.persistence.repositories.posts")

        configure do |config|
          config.template = "posts/index"
        end

        def locals(options = {})
          super.merge(
            posts: posts.listing
          )
        end
      end
    end
  end
end
