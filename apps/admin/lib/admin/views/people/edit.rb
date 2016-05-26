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
            person_form: person_form(prepare_values(person), person_validation),
            csrf_token: options[:scope].csrf_token
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

        def prepare_values(person)
          person.to_h.merge(
            avatar: person.avatar.value,
            twitter: person.twitter.value,
            website: person.website.value,
            job_title: person.job_title.value
          )
        end
      end
    end
  end
end
