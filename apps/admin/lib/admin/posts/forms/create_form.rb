require "berg/form"

module Admin
  module Posts
    module Forms
      class CreateForm < Berg::Form
        include Admin::Import[
          "admin.persistence.repositories.users",
          "admin.persistence.repositories.categories"
        ]

        prefix :post

        define do
          section :post do
            group do
              text_field :title, label: "Title"
            end
            group do
              text_area :teaser, label: "Teaser"
              selection_field :author_id, label: "Author", options: dep(:author_list)
            end

            text_area :body, label: "Body"

            multi_selection_field :post_categories,
              label: "Categories",
              selector_label: "Choose categories",
              options: dep(:categories_list)
          end
        end

        def author_list
          users.listing.map { |user| { id: user.id, label: user.full_name } }
        end

        def categories_list
          categories.listing.to_a.map { |category|
            {
              id: category.id,
              label: category.name,
              slug: category.slug
            }
          }
        end
      end
    end
  end
end
