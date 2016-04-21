require "berg/validation/form"

module Admin
  module Users
    module Validation
      Form = Berg::Validation.Form do
        optional(:email).required
        optional(:name).required
        optional(:password).required(min_size?: 8)
      end
    end
  end
end
