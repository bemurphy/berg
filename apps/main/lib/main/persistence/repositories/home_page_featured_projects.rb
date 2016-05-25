require "berg/repository"

module Main
  module Persistence
    module Repositories
      class HomePageFeaturedProjects < Berg::Repository[:home_page_featured_projects]
        relations :home_page_featured_projects

        def listing_by_position
          home_page_featured_projects
            .order(:position)
            .to_a
        end
      end
    end
  end
end
