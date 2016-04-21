require "admin/users/validation/form"
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
          validation = Validation::Form.(attributes)

          if validation.messages.any?
            Left(validation.messages)
          else
            users.update(id, prepare_attributes(validation))
            Right(users[user_id])
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
