require "main/import"
require "main/view"

module Main
  module Views
    module Pages
      class Home < Main::View
        include Main::Import(
          "main.persistence.repositories.home_page_featured_projects"
        )

        configure do |config|
          config.template = "pages/home"
        end

        def locals(options = {})
          super.merge(
            projects: home_page_featured_projects.listing_by_position
          )
        end
      end
    end
  end
end
