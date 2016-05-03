require "admin/import"
require "admin/entities/user"
require "admin/users/validation/password_form"
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
          validation = Validation::PasswordForm.(attributes)

          if validation.success?
            result = users.update(id, prepare_attributes(validation.output))
            Right(result)
          else
            Left(validation)
          end
        end

        private

        def prepare_attributes(attributes)
          {encrypted_password: encrypt_password.(attributes[:password])}
        end
      end
    end
  end
end
