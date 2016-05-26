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
            featured_items = home_page_featured_items.listing_by_position.to_a.map(&:to_h)

            super.merge(
              page_form: form_data(featured_items, options[:validation])
            )
          end

          private

          def form_data(featured_items, validation)
            if validation
              edit_form.build(validation, validation.messages)
            else
              edit_form.build(featured_items)
            end
          end
        end
      end
    end
  end
end
