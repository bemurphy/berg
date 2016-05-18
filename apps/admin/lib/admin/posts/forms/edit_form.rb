require "berg/form"

module Admin
  module Posts
    module Forms
      class EditForm < Berg::Form
        include Admin::Import[
          "admin.persistence.repositories.users",
          "admin.persistence.repositories.categories"
        ]

        prefix :post

        define do
          text_field :title, label: "Title"
          text_field :teaser, label: "Teaser"
          text_area :body, label: "Body"
          text_field :slug, label: "Slug"
          selection_field :author_id, label: "Author", options: dep(:author_list)
          select_box :status, label: "Status", options: dep(:status_list)
          date_time_field :published_at, label: "Published at"
          select_box :colour,
            label: "Colour",
            selector_label: "Choose colour",
            options: dep(:colour_list)
          multi_selection_field :post_categories,
            label: "Categories",
            selector_label: "Choose categories",
            options: dep(:categories_list)

        end

        def author_list
          users.listing.map { |user| { id: user.id, label: user.full_name } }
        end

        def status_list
          Entities::Post::Status.values.map { |value| [value, value.capitalize] }
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

        def colour_list
          Types::Colour.values.map { |value| [value, value.capitalize] }
        end
      end
    end
  end
end
