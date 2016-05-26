require "berg/form"

module Admin
  module Projects
    module Forms
      class EditForm < Berg::Form
        include Admin::Import["admin.persistence.repositories.projects"]

        prefix :project

        define do
          text_field :title, label: "Title"
          text_field :client, label: "Client"
          text_field :url, label: "URL"
          text_area :intro, label: "Introduction"
          text_area :body, label: "Body"
          text_field :slug, label: "Slug"
          text_field :tags, label: "Tags"
          select_box :status, label: "Status", options: [
            ["draft", "Draft"], ["published", "Published"], ["deleted", "Deleted"]
          ]
          date_time_field :published_at, label: "Published at"
          check_box :case_study, label: "Case Study", question_text: "Mark as a Case Study?"
        end
      end
    end
  end
end
