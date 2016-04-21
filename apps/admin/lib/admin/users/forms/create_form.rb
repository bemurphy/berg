require "berg/form"

module Admin
  module Users
    module Forms
      class CreateForm < Berg::Form
        prefix :user

        define do
          text_field :email,
            label: "Email",
            validation: {
              filled: true,
              format: "/.+@.+\..+/i"
            }
          text_field :name, label: "Name"
        end
      end
    end
  end
end
