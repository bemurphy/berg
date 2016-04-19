require "admin/validation/user_schema"
require "admin/entities/user"
require "admin/import"
require "either_result_matcher"
require "kleisli"

module Admin
  module Operations
    module Users
      class UpdateUser
        include Admin::Import(
          "admin.persistence.repositories.users",
          "core.authentication.encrypt_password"
        )

        include EitherResultMatcher.for(:call)

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
