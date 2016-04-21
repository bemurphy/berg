require "admin/import"
require "admin/entities/user"
require "admin/users/emails/password_reset"

module Admin
  module Users
    module Operations
      class SendPasswordResetEmail
        include Admin::Import(
          "admin.mailer",
          "admin.persistence.repositories.users"
        )

        def call(user)
          mail = Emails::PasswordReset.new(user: user)
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
