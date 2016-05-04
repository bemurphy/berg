require "berg/form"

module Admin
  module Posts
    module Forms
      class CreateForm < Berg::Form
        include Admin::Import["admin.persistence.repositories.users"]

        prefix :post

        define do
          text_field :title, label: "Title"
          text_area :body, label: "Body"
          text_field :slug, label: "Slug"
          selection_field :author_id, label: "Author", options: dep(:author_list)
        end

        def author_list
          users.listing.map { |user| { id: user.id, label: user.full_name } }
        end
      end
    end
  end
end
