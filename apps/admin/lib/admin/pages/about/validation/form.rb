require "admin/container"
require "berg/validation/form"

module Admin
  module Pages
    module About
      module Validation
        Form = Berg::Validation.Form do
          configure do
            config.messages = :i18n
          end

          optional(:about_page_people).each(:int?)
        end
      end
    end
  end
end
