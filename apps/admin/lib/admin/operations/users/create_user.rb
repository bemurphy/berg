require "admin/validation/user_create_schema"
require "admin/entities/user"
require "admin/import"
require "either_result_matcher"
require "kleisli"

module Admin
  module Operations
    module Users
      class CreateUser
        include Admin::Import(
          "admin.persistence.repositories.users",
          "admin.authentication.encrypt_password"
        )

        include EitherResultMatcher.for(:call)

        def call(attributes)
          validation = Validation::UserCreateSchema.(attributes)

          if validation.messages.any?
            Left(validation.messages)
          else
            user = Entities::User.new(create_user.(prepare_attributes(validation.output)))
            Right(user)
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
