# require "either_result_matcher"
# require "kleisli"
require "main/import"

module Main
  module Operations
    module Posts
      class CheckPublicationState
        include Main::Import("main.persistence.repositories.posts")
        include Dry::ResultMatcher.for(:call)

        def call(slug)
          post = posts.by_slug(slug)

          if post.status == "published"
            Right(post)
          else
            Left("Could not find post")
          end
        end
      end
    end
  end
end
