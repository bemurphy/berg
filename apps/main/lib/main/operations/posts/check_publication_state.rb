require "main/import"

module Main
  module Operations
    module Posts
      class CheckPublicationState
        include Main::Import("main.persistence.repositories.posts")
        include Dry::ResultMatcher.for(:call)

        def call(slug)
          post = posts.by_slug(slug)

          if post && post.status == "published"
            Right(post)
          else
            Left("This post has not yet been published.")
          end
        end
      end
    end
  end
end
