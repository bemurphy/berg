require "dry-validation"
require "dry/validation/schema/form"

module Admin
  module Validation
    class AdminUserFormSchema < Dry::Validation::Schema::Form
      configure { config.messages = :i18n }

      key(:name) { |name| name.filled? }
      key(:email) { |email| email.filled? }
      confirmation(:password)
    end
  end
end
