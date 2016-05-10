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
          posts
          .by_slug(slug)
          .combine(one: { author: [users, author_id: :id] })
          .as(Entities::Post::WithAuthor).one
        end

        def slug_exists?(slug)
          !!posts.matching_slugs(slug).one
        end

        def listing(page: 1, per_page: 20)
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
