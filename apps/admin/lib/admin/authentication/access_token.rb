require "admin/import"
require "dry-result_matcher"

module Admin
  module Authentication
    class AccessToken
      include Admin::Import(
        "admin.persistence.repositories.users"
      )

      include Dry::ResultMatcher.for(:call)

      def call(access_token)
        user = users.by_access_token(access_token)

        if user
          Right(user)
        else
          Left(:access_token_invalid)
        end
      end
    end
  end
end
