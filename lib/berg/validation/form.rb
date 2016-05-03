require "dry-validation"

module Berg
  module Validation
    class Form < Dry::Validation::Schema::Form
      EMAIL_REGEX = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/.freeze

      configure do |config|
        config.messages = :i18n
      end

      def email?(input)
        EMAIL_REGEX.match(input).size > 0
      end
    end

    def self.Form(&block)
      Dry::Validation.Schema(Form, &block)
    end
  end
end
