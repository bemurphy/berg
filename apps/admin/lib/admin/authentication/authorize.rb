require "admin/import"
require "dry-result_matcher"

module Admin
  module Authentication
    class Authorize
      include Admin::Import(
        "core.authentication.encrypt_password",
        "admin.persistence.repositories.users"
      )

      include Dry::ResultMatcher.for(:call)

      def call(session)
        id = session[:user_id]
        user = id && users[id]

        if user
          Right(user)
        else
          Left(:unauthorized)
        end
      end

      def default_password?(user)
        encrypt_password.same?(user.encrypted_password, Types::Password.value)
      end
    end
  end
end
