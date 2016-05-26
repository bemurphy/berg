require "berg/repository"
require "main/entities/post"

module Main
  module Persistence
    module Repositories
      class Posts < Berg::Repository[:posts]
        relations :posts, :users, :categories

        def by_slug(slug)
          posts
          .by_slug(slug)
          .combine(one: { author: [users, author_id: :id] })
          .combine(many: { categories: [categories, id: :post_id] })
          .as(Entities::Post::WithAuthorAndCategories).one
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

        def for_category(category_id, page: 1, per_page: 20)
          posts
            .published
            .for_category(category_id)
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
