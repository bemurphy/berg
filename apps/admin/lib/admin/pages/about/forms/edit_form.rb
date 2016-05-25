require "berg/form"

module Admin
  module Pages
    module About
      module Forms
        class EditForm < Berg::Form
          include Admin::Import[
            "admin.persistence.repositories.people"
          ]

          prefix :page

          define do
            multi_selection_field :about_page_people,
              label: "People",
              selector_label: "Choose people",
              options: dep(:people_list)
          end

          def people_list
            people.all_people.to_a.map { |person|
              {
                id: person.id,
                label: person.full_name
              }
            }
          end
        end
      end
    end
  end
end
