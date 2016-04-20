require "admin/import"
require "authentication/authenticate"

module Admin
  module Authentication
    class Authenticate < ::Authentication::Authenticate
      include Admin::Import(
        "core.authentication.encrypt_password",
        "admin.persistence.repositories.users"
      )

      def fetch(email)
        users.by_email(email)
      end
    end
  end
end
