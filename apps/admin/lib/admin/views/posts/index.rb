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
          page      = options[:page] || 1
          per_page  = options[:per_page] || 20

          all_posts = posts.listing(page: page, per_page: per_page)
          admin_posts = all_posts.to_a.map { |a| Decorators::Post.new(a) }

          super.merge(
            posts: admin_posts,
            paginator: Paginator.new(all_posts.pager, url_template: "/admin/posts?page=%")
          )
        end
      end
    end
  end
end
