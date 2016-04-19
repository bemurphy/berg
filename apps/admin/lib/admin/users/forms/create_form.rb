require "formalist"
require "formalist/elements/standard"

module Admin
  module Users
    module Forms
      CreateForm = Class.new(Formalist::Form) do
        define do
          section :user do
            text_field :name,
              label: "Name",
              validation: {filled?: true}

            text_field :email,
              label: "Email",
              validation: {filled?: true}

            text_field :password,
              label: "Password",
              password: true,
              hint: "Leave blank if you don't want to change it"

            text_field :password_confirmation,
              label: "Password confirmation",
              password: true
          end
        end
      end.new
    end
  end
end
