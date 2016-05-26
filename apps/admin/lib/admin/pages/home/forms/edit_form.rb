require "berg/form"

module Admin
  module Pages
    module Home
      module Forms
        class EditForm < Berg::Form
          include Admin::Import[
            "admin.persistence.repositories.home_page_featured_items"
          ]

          prefix :page

          define do
            many :home_page_featured_items,
              label: "Featured Items",
              action_label: "Add a featured item",
              placeholder: "No featured items added yet.",
              validation: {} do
                text_field :title,
                  label: "Title"

                text_field :description,
                  label: "Description"

                text_field :url,
                  label: "URL"

                text_field :image_id,
                  label: "Image ID"
            end
          end
        end
      end
    end
  end
end
