require "admin/import"
require "admin/users/emails/account_activation"

module Admin
  module Users
    module Operations
      class SendActivationEmail
        include Admin::Import(
          "admin.mailer",
          "admin.persistence.repositories.users"
        )

        def call(user)
          mail = Emails::AccountActivation.new(user: user)
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
