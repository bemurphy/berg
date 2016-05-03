require "admin/import"
require "admin/view"
require "admin/users/forms/password_form"

module Admin
  module Views
    module Users
      class Password < Admin::View
        include Admin::Import(
          "admin.persistence.repositories.users",
          "admin.users.forms.password_form"
        )

        configure do |config|
          config.template = "users/password"
        end

        def locals(options = {})
          user = users[options[:id]]

          pass_validation = options[:pass_validation]

          super.merge(
            user: user,
            pass_form: pass_form(pass_validation)
          )
        end

        private

        def pass_form(validation)
          if validation
            password_form.build({}, validation.messages)
          else
            password_form.build
          end
        end
      end
    end
  end
end
