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

        def call(id, attributes)
          validation = Validation::Form.(attributes)

          if validation.success?
            users.update(id, validation.output)
            Right(users[id])
          else
            Left(validation)
          end
        end
      end
    end
  end
end
