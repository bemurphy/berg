require "main/import"
require "main/view"

module Main
  module Views
    module Pages
      class Home < Main::View
        include Main::Import(
          "main.persistence.repositories.projects"
        )

        configure do |config|
          config.template = "pages/home"
        end

        def locals(options = {})
          super.merge(
            projects: projects.for_home_page
          )
        end
      end
    end
  end
end
