require "berg/repository"

module Admin
  module Persistence
    module Repositories
      class HomePageFeaturedItems < Berg::Repository[:home_page_featured_items]
        relations :home_page_featured_items

        def listing_by_position
          home_page_featured_items
            .order(:position)
            .to_a
        end
      end
    end
  end
end
