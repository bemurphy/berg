require "berg/form"

module Admin
  module Projects
    module Forms
      class EditForm < Berg::Form
        include Admin::Import["admin.persistence.repositories.projects"]

        prefix :post

        define do
          text_field :title, label: "Title"
          text_field :client, label: "Client"
          text_field :url, label: "URL"
          text_area :intro, label: "Introduction"
          text_area :body, label: "Body"
          text_field :tags, label: "Tags"
          select_box :status, label: "Status", options: [
            ["draft", "Draft"], ["published", "Published"], ["deleted", "Deleted"]
          ]
        end
      end
    end
  end
end
