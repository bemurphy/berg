require "main/import"
require "main/paginator"
require "main/view"
require "main/decorators/public_post"

module Main
  module Views
    module Posts
      class Index < Main::View
        include Main::Import("main.persistence.repositories.posts")

        configure do |config|
          config.template = "posts/index"
        end

        def locals(options = {})
          page      = options[:page] || 1
          per_page  = options[:per_page] || 20

          all_posts = posts.listing(page: page, per_page: per_page)
          public_posts = all_posts.to_a.map { |a| Decorators::PublicPost.new(a) }

          super.merge(
            posts: public_posts.to_a,
            paginator: Paginator.new(all_posts.pager, url_template: "/posts?page=%")
          )
        end
      end
    end
  end
end
