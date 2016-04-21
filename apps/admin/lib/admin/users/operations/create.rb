require "admin/users/validation/form"
require "admin/entities/user"
require "admin/import"
require "dry-result_matcher"
require "kleisli"

module Admin
  module Users
    module Operations
      class Create
        include Admin::Import(
          "admin.persistence.repositories.users",
          "admin.users.access_token",
          "core.authentication.encrypt_password"
        )

        include Dry::ResultMatcher.for(:call)

        def call(attributes)
          validation = Validation::Form.(attributes)

          if validation.messages.any?
            Left(validation.messages)
          else
            user = Entities::User.new(users.create(prepare_attributes(validation)))
            Right(user)
          end
        end

        private

        def prepare_attributes(attributes)
          attributes.merge(
            encrypted_password: encrypt_password.(attributes[:password]),
            access_token: access_token.value,
            access_token_expiration: access_token.expires_at
          )
        end
      end
    end
  end
end
