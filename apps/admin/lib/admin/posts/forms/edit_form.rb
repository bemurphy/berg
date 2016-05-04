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
          select_box :author, label: "Author", options: [
            dep(:author_list)
          ]
          select_box :status, label: "Status", options: [
            ["draft", "Draft"], ["published", "Published"], ["deleted", "Deleted"]
          ]
        end

        def author_list
          Entities::User.full_name.map { |full_name| [full_name, full_name.capitalize] }
        end
      end
    end
  end
end
