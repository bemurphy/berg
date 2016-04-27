require "admin/email"

module Admin
  module Users
    module Emails
      class PasswordReset < Admin::Email
        configure do |config|
          config.template = "password_reset"
        end

        def locals(*)
          { user: user, password_reset_url: password_reset_url }
        end

        def to
          user.email
        end

        def subject
          t["admin.emails.users.password_reset.subject"]
        end

        def password_reset_url
          "#{Berg::Container["config"].admin_url}/users/update-password/#{user.access_token}"
        end

        def user
          options.fetch(:user)
        end
      end
    end
  end
end
