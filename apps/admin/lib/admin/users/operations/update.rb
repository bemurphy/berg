require "admin/import"
require "admin/entities/user"
require "admin/users/validation/form"
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
          validation = Validation::Form.(prepare_attributes(attributes))
          if validation.success?
            users.update(id, validation.output)
            Right(users[id])
          else
            Left(validation)
          end
        end

        private

        def prepare_attributes(attributes)
          attributes.merge(
            previous_email: attributes["email"]
          )
        end
      end
    end
  end
end
