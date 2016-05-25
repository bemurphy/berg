require "admin/container"
require "berg/validation/form"

module Admin
  module Pages
    module Home
      module Validation
        Form = Berg::Validation.Form do
          configure do
            config.messages = :i18n
          end

          optional(:home_page_featured_projects).each(:int?)
        end
      end
    end
  end
end
