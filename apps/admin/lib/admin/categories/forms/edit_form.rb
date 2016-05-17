require "berg/form"

module Admin
  module Categories
    module Forms
      class EditForm < Berg::Form
        include Admin::Import["admin.persistence.repositories.categories"]

        prefix :category

        define do
          text_field :name, label: "Name"
          text_field :slug, label: "Slug"
        end
      end
    end
  end
end
