require "berg/repository"
require "admin/entities/home_page_featured_project"

module Admin
  module Persistence
    module Repositories
      class HomePageFeaturedProjects < Berg::Repository[:home_page_featured_projects]
        commands :create, :update

        def [](id)
          projects.by_id(id).as(Entities::HomePageFeaturedProject).one
        end

        def listing
          home_page_featured_projects.order(:position).as(Entities::HomePageFeaturedProject)
        end
      end
    end
  end
end
