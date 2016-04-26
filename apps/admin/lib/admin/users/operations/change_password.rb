require "admin/import"
require "admin/entities/user"
require "admin/users/validation/form"
require "dry-result_matcher"

module Admin
  module Users
    module Operations
      class ChangePassword
        include Admin::Import(
          "admin.persistence.repositories.users",
          "core.authentication.encrypt_password"
        )

        include Dry::ResultMatcher.for(:call)

        def call(id, attributes)
          validation = Validation::Form.(attributes)

          if validation.messages.any?
            Left(validation.messages)
          else
            result = users.update(id, prepare_attributes(validation.output))
            Right(result)
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
