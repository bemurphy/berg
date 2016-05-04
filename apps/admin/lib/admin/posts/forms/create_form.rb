require "berg/form"

module Admin
  module Posts
    module Forms
      class CreateForm < Berg::Form
        prefix :post

        define do
          text_field :title, label: "Title"
          text_field :body, label: "Body"
          text_field :slug, label: "Slug"
          select_box :author, label: "Author", options: [
            dep(:author_list)
          ]
        end

        def author_list
          Entities::User.full_name.map { |full_name| [full_name, full_name.capitalize] }
        end
      end
    end
  end
end
