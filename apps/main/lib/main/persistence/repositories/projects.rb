require "berg/repository"
require "main/entities/project"

module Main
  module Persistence
    module Repositories
      class Projects < Berg::Repository[:projects]
        relations :projects

        def by_slug(slug)
          projects.by_slug(slug).as(Entities::Project).one
        end

        def listing
          projects.published.order(Sequel.desc(:published_at)).as(Entities::Project)
        end
      end
    end
  end
end
