require "berg/repository"

module Admin
  module Persistence
    module Repositories
      class AboutPagePeople < Berg::Repository[:about_page_people]
        relations :about_page_people

        def listing_by_position
          about_page_people
            .order(:position)
            .to_a
        end
      end
    end
  end
end
