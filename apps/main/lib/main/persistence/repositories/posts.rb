require "berg/repository"
require "main/entities/post"

module Main
  module Persistence
    module Repositories
      class Posts < Berg::Repository[:posts]
        relations :posts, :users

        def by_slug(slug)
          posts
          .by_slug(slug)
          .combine(one: { author: [users, author_id: :id] })
          .as(Entities::Post::WithAuthor).one
        end

        def listing(per_page: 20, page: 1)
          posts
            .published
            .per_page(per_page)
            .page(page)
            .order(:published_at)
            .combine(one: { author: [users, author_id: :id] })
            .as(Entities::Post::WithAuthor)
        end
      end
    end
  end
end
