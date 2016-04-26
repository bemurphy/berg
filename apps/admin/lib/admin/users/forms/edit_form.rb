require "berg/form"

module Admin
  module Users
    module Forms
      class EditForm < Berg::Form
        prefix :user

        define do
          text_field :email,
            label: "Email",
            validation: {
              filled: true,
              format: "/.+@.+\..+/i"
            }
          text_field :name, label: "Name"
          check_box :active, label: "Status", question_text: "Mark as active?"
        end
      end
    end
  end
end
