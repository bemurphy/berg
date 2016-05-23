require "admin/container"
require "berg/validation/form"

module Admin
  module Users
    module Validation
      Form = Berg::Validation.Form do
        configure do
          config.messages = :i18n

          option :user_email_uniqueness_check, Admin::Container["admin.persistence.user_email_uniqueness_check"]

          def email_unique?(value)
            user_email_uniqueness_check.(value)
          end

          def not_eql?(input, value)
            !input.eql?(value)
          end
        end

        optional(:email).filled
        optional(:previous_email).maybe
        optional(:first_name).filled
        optional(:last_name).filled
        optional(:bio).maybe
        optional(:short_bio).maybe
        optional(:website).maybe
        optional(:twitter).maybe
        optional(:job_title).maybe
        optional(:active).filled(:bool?)
        optional(:password).filled(min_size?: 8)

        rule(email: [:email, :previous_email]) do |email, previous_email|
          email.not_eql?(previous_email).then(email.email_unique?)
        end
      end
    end
  end
end
