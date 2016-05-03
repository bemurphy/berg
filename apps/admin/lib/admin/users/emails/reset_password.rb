require "admin/email"

module Admin
  module Users
    module Emails
      class ResetPassword < Admin::Email
        configure do |config|
          config.template = "reset_password"
        end

        def locals(*)
          { user: user, reset_password_url: reset_password_url }
        end

        def to
          user.email
        end

        def subject
          t["admin.emails.users.reset_password.subject"]
        end

        def reset_password_url
          "#{Berg::Container["config"].admin_url}/reset-password/#{user.access_token}"
        end

        def user
          options.fetch(:user)
        end
      end
    end
  end
end
