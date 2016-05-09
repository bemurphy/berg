require "main/import"
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
          super.merge(
            posts: posts.listing
          )
        end
      end
    end
  end
end
