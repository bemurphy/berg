require "main/import"
require "main/view"
require "main/decorators/public_post"

module Main
  module Views
    module Posts
      module Category
        class Index < Main::View
          include Main::Import(
            "main.persistence.repositories.posts",
            "main.persistence.repositories.categories",
          )

          configure do |config|
            config.template = "posts/category/index"
          end

          def locals(options = {})
            options = {per_page: 20, page: 1}.merge(options)

            category_slug = options.fetch(:category)
            category      = categories.by_slug!(category_slug)
            all_posts     = posts.for_category(category.id, page: options[:page], per_page: options[:per_page])

            super.merge(
              category: category,
              posts: Decorators::PublicPost.decorate(all_posts),
              paginator: all_posts.pager
            )
          end
        end
      end
    end
  end
end
