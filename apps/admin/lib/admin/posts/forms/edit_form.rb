require "berg/form"

module Admin
  module Posts
    module Forms
      class EditForm < Berg::Form
        prefix :post

        define do
          text_field :title, label: "Title"
          text_field :body, label: "Body"
          text_field :slug, label: "Slug"
        end
      end
    end
  end
end
