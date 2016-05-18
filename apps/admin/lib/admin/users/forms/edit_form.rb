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
          text_field :first_name, label: "First name"
          text_field :last_name, label: "Last name"
          text_area :bio, label: "Bio", hint: "(optional)"
          upload_field :avatar,
            label: "Avatar",
            hint: "An image of this user",
            presign_url: "#{Berg::Container["config"].canonical_domain}/admin/uploads/presign"
          check_box :active, label: "Status", question_text: "Mark as active?"
        end
      end
    end
  end
end
