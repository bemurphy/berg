require "berg/validation/form"

module Admin
  module Users
    module Validation
      Form = Berg::Validation.Form do
        optional(:email).filled
        optional(:first_name).filled
        optional(:last_name).filled
        optional(:active).filled(:bool?)
        optional(:password).filled(min_size?: 8)
      end
    end
  end
end
