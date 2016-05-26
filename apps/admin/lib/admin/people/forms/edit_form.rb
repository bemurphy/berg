require "berg/form"

module Admin
  module People
    module Forms
      class EditForm < Berg::Form
        prefix :person

        define do
          group do
            text_field :first_name, label: "First name"
            text_field :last_name, label: "Last name"
          end
          group do
            text_field :email,
              label: "Email",
              validation: {
                filled: true,
                format: EMAIL_VALIDATION_REGEX
              }
            text_field :job_title, label: "Job Title"
          end
          group do
            text_field :twitter, label: "Twitter Username"
            text_field :website, label: "Website URL"
          end
          text_area :bio, label: "Bio"
          text_area :short_bio, label: "Short Bio"
        end
      end
    end
  end
end
