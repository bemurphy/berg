require "admin/import"
require "admin/paginator"
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
          options = { per_page: 20, page: 1 }.merge(options)
          all_posts = posts.listing(page: options[:page], per_page: options[:per_page])

          super.merge(
            posts: all_posts,
            paginator: Paginator.new(all_posts.pager, url_template: "/admin/posts?page=%")
          )
        end
      end
    end
  end
end
