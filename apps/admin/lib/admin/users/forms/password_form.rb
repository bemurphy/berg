require "berg/form"

module Admin
  module Users
    module Forms
      class PasswordForm < Berg::Form
        prefix :user

        define do
          text_field :password, type: "string", password: true, label: "Password"
        end
      end
    end
  end
end
