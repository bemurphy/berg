require "berg/repository"

module Admin
  module Persistence
    module Repositories
      class HomePageFeaturedProjects < Berg::Repository[:home_page_featured_projects]
        relations :home_page_featured_projects

        def all_featured_projects
          home_page_featured_projects
            .order(:position)
            .to_a
        end
      end
    end
  end
end
