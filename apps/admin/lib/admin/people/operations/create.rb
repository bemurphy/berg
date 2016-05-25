require "admin/import"
require "admin/entities/person"
require "admin/people/validation/form"
require "kleisli"
require "types"

module Admin
  module People
    module Operations
      class Create
        include Admin::Import(
          "admin.persistence.repositories.people",
        )

        include Dry::ResultMatcher.for(:call)

        def call(attributes)
          validation = Validation::Form.(attributes)

          if validation.success?
            person = Entities::Person.new(people.create(validation.output))
            Right(person)
          else
            Left(validation)
          end
        end
      end
    end
  end
end
