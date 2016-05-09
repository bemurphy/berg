require "main/import"
require "main/paginator"
require "main/view"

module Main
  module Views
    module Posts
      class Index < Main::View
        include Main::Import("main.persistence.repositories.posts")

        configure do |config|
          config.template = "posts/index"
        end

        def locals(options = {})
          options = {per_page: 1, page: 1}.merge(options)
          all_posts = posts.listing(page: options[:page], per_page: options[:per_page])

          super.merge(
            posts: all_posts.to_a,
            paginator: Paginator.new(all_posts.pager, url_template: "/posts?page=%")
          )
        end
      end
    end
  end
end
