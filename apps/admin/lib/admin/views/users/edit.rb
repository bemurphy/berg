require "admin/view"
require "admin/forms/users/edit_form"

module Admin
  module Views
    module User
      class Edit < Admin::View
        configure do |config|
          config.template = "user/edit"
        end

        def locals(options = {})
          account = options[:scope].current_user

          result = options[:result]
          input = result ? result.output : form_input(account)
          errors = result ? result.messages : {}

          form = Forms::Users::EditForm.build(input, errors)

          super.merge(
            account: account,
            admin_user_form: form
          )
        end

        private

        def form_input(account)
          account.to_h.select{ |key, value| key == :name || key == :email }
        end
      end
    end
  end
end
