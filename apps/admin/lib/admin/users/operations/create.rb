require "admin/users/validation/user_schema"
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
          "core.authentication.encrypt_password"
        )

        include Dry::ResultMatcher.for(:call)

        def call(attributes)
          validation = Validation::UserSchema.(attributes)

          if validation.messages.any?
            Left(validation.messages)
          else
            user = Entities::User.new(create_user.(prepare_attributes(validation.output)))
            Right(user)
          end
        end

        private

        def prepare_attributes(attributes)
          attributes.merge(
            encrypted_password: encrypt_password.(attributes[:password])
          )
        end
      end
    end
  end
end
