require "admin/import"
require "admin/pages/home/forms/edit_form"
require "admin/view"

module Admin
  module Views
    module Pages
      module Home
        class Edit < Admin::View
          include Admin::Import(
            "admin.persistence.repositories.home_page_featured_items",
            "admin.pages.home.forms.edit_form"
          )

          configure do |config|
            config.template = "pages/home/edit"
          end

          def locals(options = {})
            super.merge(
              page_form: form_data(options[:validation])
            )
          end

          private

          def form_data(validation)
            if validation
              edit_form.build(validation, validation.messages)
            else
              edit_form.build
            end
          end
        end
      end
    end
  end
end
