require "berg/repository"
require "main/entities/post"

module Main
  module Persistence
    module Repositories
      class Posts < Berg::Repository[:posts]
        relations :posts, :users

        def [](id)
          posts.by_id(id).as(Entities::Post).one
        end

        def by_slug(slug)
          posts.by_slug(slug).as(Entities::Post).one
        end

        def slug_exists?(slug)
          !!posts.matching_slugs(slug).one
        end

        def listing
          posts
            .combine(one: { author: [users, author_id: :id] })
            .as(Entities::Post::WithAuthor).to_a
        end
      end
    end
  end
end
