require "admin/users/validation/user_schema"
require "admin/entities/user"
require "admin/import"
require "dry-result_matcher"
require "kleisli"

module Admin
  module Users
    module Operations
      class Update
        include Admin::Import(
          "admin.persistence.repositories.users",
          "core.authentication.encrypt_password"
        )

        include Dry::ResultMatcher.for(:call)

        def call(user_id, attributes)
          validation = Validation::UserSchema.(attributes)

          if validation.messages.any?
            Left(validation.messages)
          else
            update_user.by_id(user_id).(prepare_attributes(validation.output))
            Right(users[user_id])
          end
        end

        private

        def prepare_attributes(attributes)
          if attributes[:password]
            attributes.merge(encrypted_password: encrypt_password.(attributes[:password]))
          else
            attributes
          end
        end
      end
    end
  end
end
