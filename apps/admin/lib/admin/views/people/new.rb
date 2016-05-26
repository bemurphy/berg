require "admin/import"
require "admin/view"

module Admin
  module Views
    module People
      class New < Admin::View
        include Admin::Import("admin.people.forms.create_form")

        configure do |config|
          config.template = "people/new"
        end

        def locals(options = {})
          super.merge(
            person_form: form_data(options[:validation]),
            csrf_token: options[:scope].csrf_token
          )
        end

        def form_data(validation)
          if validation
            create_form.build(validation, validation.messages)
          else
            create_form.build
          end
        end
      end
    end
  end
end
