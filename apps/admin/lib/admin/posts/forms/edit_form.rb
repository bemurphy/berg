require "berg/form"

module Admin
  module Posts
    module Forms
      class CreateForm < Berg::Form
        prefix :post

        define do
          text_field :title, label: "Title"
          text_field :content, label: "Content"
          text_field :slug, label: "Slug"
        end
      end
    end
  end
end
