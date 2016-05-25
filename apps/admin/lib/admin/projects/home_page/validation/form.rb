require "admin/import"
require "berg/validation/form"

module Admin
  module Projects
    module HomePage
      module Validation
        Form = Berg::Validation.Form do
          configure do
            config.messages = :i18n
          end

          # Required in both the new and edit forms
          required(:title).filled
          required(:client).filled
          required(:url).filled
          required(:intro).filled
        end
      end
    end
  end
end
