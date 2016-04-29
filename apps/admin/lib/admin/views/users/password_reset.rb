require "admin/view"

module Admin
  module Views
    module Users
      class PasswordReset < Admin::View
        configure do |config|
          config.template = "users/password_reset"
        end
      end
    end
  end
end
