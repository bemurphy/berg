require "admin/import"
require "admin/view"
require "admin/users/forms/edit_form"
require "admin/users/forms/password_form"

module Admin
  module Views
    module Users
      class Edit < Admin::View
        include Admin::Import(
          "admin.persistence.repositories.users",
          "admin.users.forms.edit_form",
          "admin.users.forms.password_form"
        )

        configure do |config|
          config.template = "users/edit"
        end

        def locals(options = {})
          user = users[options[:id]]

          user_validation = options[:user_validation]
          pass_validation = options[:pass_validation]

          super.merge(
            user: user,
            user_form: user_form(form_input(user), user_validation),
            pass_form: pass_form(pass_validation),
            csrf_token: options[:scope].csrf_token
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

        def user_form(user, validation)
          if validation
            edit_form.build(validation, validation.messages)
          else
            edit_form.build(user)
          end
        end

        def form_input(user)
          user.to_h.merge(
            bio: user.bio.value,
            website: user.website.value,
            twitter: user.twitter.value,
            job_title: user.job_title.value
          )
        end
      end
    end
  end
end
