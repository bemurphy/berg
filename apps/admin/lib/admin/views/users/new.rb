require "admin/import"
require "admin/view"
require "admin/users/forms/create_form"

module Admin
  module Views
    module Users
      class New < Admin::View
        include Admin::Import("admin.users.forms.create_form")

        configure do |config|
          config.template = "users/new"
        end

        def locals(options = {})
          super.merge(user_form: form_data(options[:validation]))
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
