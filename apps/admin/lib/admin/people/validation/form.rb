require "admin/container"
require "berg/validation/form"

module Admin
  module People
    module Validation
      Form = Berg::Validation.Form do
        configure do
          config.messages = :i18n

          option :person_email_uniqueness_check, Admin::Container["admin.persistence.person_email_uniqueness_check"]

          def email_unique?(value)
            person_email_uniqueness_check.(value)
          end

          def not_eql?(input, value)
            !input.eql?(value)
          end
        end

        optional(:email).filled
        optional(:bio).filled
        optional(:previous_email).maybe
        optional(:first_name).filled
        optional(:last_name).filled

        optional(:avatar).maybe(:str?)
        optional(:twitter).maybe(:str?)
        optional(:job_title).maybe(:str?)
        optional(:website).maybe(:str?)

        optional(:active).filled(:bool?)

        rule(email: [:email, :previous_email]) do |email, previous_email|
          email.not_eql?(previous_email).then(email.email_unique?)
        end
      end
    end
  end
end
