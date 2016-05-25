require "berg/repository"
require "main/entities/person"

module Main
  module Persistence
    module Repositories
      class AboutPagePeople < Berg::Repository[:about_page_people]
        relations :about_page_people, :people

        def all_people
          people
            .about_page_people
            .as(Entities::Person)
        end
      end
    end
  end
end
