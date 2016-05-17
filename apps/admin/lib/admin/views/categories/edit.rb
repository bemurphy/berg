require "admin/import"
require "admin/view"
require "admin/categories/forms/edit_form"

module Admin
  module Views
    module Categories
      class Edit < Admin::View
        include Admin::Import(
          "admin.persistence.repositories.categories",
          "admin.categories.forms.edit_form",
        )

        configure do |config|
          config.template = "categories/edit"
        end

        def locals(options = {})
          category = categories.by_slug(options[:slug])

          category_validation = options[:category_validation]

          super.merge(
            category: category,
            category_form: category_form(category, category_validation)
          )
        end

        private

        def category_form(category, validation)
          if validation
            edit_form.build(validation, validation.messages)
          else
            edit_form.build(category)
          end
        end
      end
    end
  end
end
