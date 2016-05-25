require "main/import"
require "main/view"

module Main
  module Views
    module Pages
      class About < Main::View
        include Main::Import(
          "main.persistence.repositories.about_page_people"
        )

        configure do |config|
          config.template = "pages/about"
        end

        def locals(options = {})
          super.merge(
            about_page_people: about_page_people.all_people,
          )
        end
      end
    end
  end
end
