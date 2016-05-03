require "admin/import"
require "admin/entities/user"
require "admin/users/emails/reset_password"

module Admin
  module Users
    module Operations
      class SendResetPasswordEmail
        include Admin::Import(
          "admin.mailer",
          "admin.persistence.repositories.users"
        )

        def call(user)
          mail = Emails::ResetPassword.new(user: user)
          mailer.deliver(mail)
        end

        def to_queue(user)
          [user.id]
        end

        def call_from_queue(id)
          call(users[id])
        end
      end
    end
  end
end
