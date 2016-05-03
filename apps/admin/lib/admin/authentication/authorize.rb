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

        if user && user.active?
          Right(user)
        else
          Left(:unauthorized)
        end
      end
    end
  end
end
