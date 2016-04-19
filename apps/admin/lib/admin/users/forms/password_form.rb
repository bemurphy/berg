require "formalist"
require "formalist/elements/standard"

module Admin
  module Users
    module Forms
      PasswordForm = Class.new(Formalist::Form) do
        define do
          section :user do
            text_field :password, type: "string", password: true, label: "Password"
          end
        end
      end
    end
  end
end
