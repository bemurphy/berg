require "dry-validation"

module Admin
  module Validation
    UserSchema = Dry::Validation.Form do
      required(:name).filled
      required(:email).filled
      optional(:password).maybe.confirmation
    end
  end
end
