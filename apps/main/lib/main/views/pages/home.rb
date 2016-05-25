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
            projects: home_page_featured_projects.all_featured_projects
          )
        end
      end
    end
  end
end
