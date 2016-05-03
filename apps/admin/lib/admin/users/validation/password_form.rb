require "berg/validation/form"

module Admin
  module Users
    module Validation
      PasswordForm = Berg::Validation.Form do
        required(:password).filled(min_size?: 8)
      end
    end
  end
end
