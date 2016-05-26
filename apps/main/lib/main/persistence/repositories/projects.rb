require "berg/repository"
require "main/entities/project"

module Main
  module Persistence
    module Repositories
      class Projects < Berg::Repository[:projects]
        relations :projects

        def for_home_page
          projects
            .for_home_page
            .as(Entities::Project)
        end
      end
    end
  end
end
