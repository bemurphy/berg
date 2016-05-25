require "admin/import"
require "admin/view"

module Admin
  module Views
    module People
      class Edit < Admin::View
        include Admin::Import(
          "admin.persistence.repositories.people",
          "admin.people.forms.edit_form",
        )

        configure do |config|
          config.template = "people/edit"
        end

        def locals(options = {})
          person = people[options[:id]]

          person_validation = options[:person_validation]

          super.merge(
            person: person,
            person_form: person_form(person, person_validation)
          )
        end

        private

        def person_form(person, validation)
          if validation
            edit_form.build(validation, validation.messages)
          else
            edit_form.build(person)
          end
        end
      end
    end
  end
end
