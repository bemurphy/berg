require "admin/import"
require "admin/entities/user"
require "dry-result_matcher"

module Admin
  module Users
    module Operations
      class UpdateAccessToken
        include Admin::Import(
          "admin.persistence.repositories.users",
          "admin.users.access_token"
        )

        include Dry::ResultMatcher.for(:call)

        def call(email)
          attributes = users.update_by_email(email,
            access_token: access_token.value,
            access_token_expiration: access_token.expires_at
          )

          if attributes
            Right(Entities::User.new(attributes))
          else
            Left(:user_not_found)
          end
        end
      end
    end
  end
end
