require "berg/form"

module Admin
  module Posts
    module Forms
      class EditForm < Berg::Form
        include Admin::Import[
          "admin.persistence.repositories.users",
          "admin.persistence.repositories.tags"
        ]

        prefix :post

        define do
          text_field :title, label: "Title"
          text_field :teaser, label: "Teaser"
          text_area :body, label: "Body"
          text_field :slug, label: "Slug"
          selection_field :author_id, label: "Author", options: dep(:author_list)
          select_box :status, label: "Status", options: [
            ["draft", "Draft"], ["published", "Published"], ["deleted", "Deleted"]
          ]
          date_time_field :published_at, label: "Published at"
          multi_selection_field :tag_ids,
            label: "Tags",
            selector_label: "Choose tags",
            options: dep(:tags_list)
        end

        def author_list
          users.listing.map { |user| { id: user.id, label: user.full_name } }
        end

        def tags_list
          tags.listing.to_a.map { |tag|
            {
              id: tag.id,
              label: tag.name,
              slug: tag.slug
            }
          }
        end
      end
    end
  end
end
