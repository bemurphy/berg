require "berg/repository"
require "main/entities/person"

module Main
  module Persistence
    module Repositories
      class AboutPagePeople < Berg::Repository[:about_page_people]
        relations :people

        def all_people
          people
            .for_about_page
            .as(Entities::Person)
        end
      end
    end
  end
end
