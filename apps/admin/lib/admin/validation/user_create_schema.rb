require "dry-validation"

module Admin
  module Validation
    UserCreateSchema = Dry::Validation.Form do
      required(:name).filled
      required(:email).filled
      optional(:password).maybe.confirmation
    end
  end
end
