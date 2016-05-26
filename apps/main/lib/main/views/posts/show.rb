require "main/import"
require "main/view"
require "main/decorators/public_post"

module Main
  module Views
    module Posts
      class Show < Main::View
        include Main::Import("main.persistence.repositories.posts")

        configure do |config|
          config.template = "posts/show"
        end

        def locals(options = {})
          super.merge(
            post: Decorators::PublicPost.decorate(posts.by_slug(options[:slug]))
          )
        end
      end
    end
  end
end
