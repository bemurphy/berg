require "admin/import"
require "admin/view"
require "admin/pages/about/forms/edit_form"

module Admin
  module Views
    module Pages
      module About
        class Edit < Admin::View
          include Admin::Import(
            "admin.persistence.repositories.about_page_people",
            "admin.persistence.repositories.people",
            "admin.pages.about.forms.edit_form",
          )

          configure do |config|
            config.template = "pages/about/edit"
          end

          def locals(options = {})
            selected_about_page_people = about_page_people.listing_by_position

            page_validation = options[:page_validation]

            super.merge(
              page_form: page_form(selected_about_page_people, page_validation)
            )
          end

          private

          def page_form(people_list, validation)
            if validation
              edit_form.build(validation, validation.messages)
            else
              edit_form.build(form_input(people_list))
            end
          end

          def form_input(people_list)
            {
              about_page_people: people_list.map(&:person_id)
            }
          end
        end
      end
    end
  end
end
