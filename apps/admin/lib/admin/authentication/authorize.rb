require "admin/import"
require "either_result_matcher"

module Admin
  module Authentication
    class Authorize
      include Admin::Import(
        "core.authentication.encrypt_password",
        "admin.persistence.repositories.users"
      )

      include EitherResultMatcher.for(:call)

      def call(session)
        id = session[:user_id]
        user = id && users[id]

        if user
          Right(user)
        else
          Left(:unauthorized)
        end
      end
    end
  end
end
