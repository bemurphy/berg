require "main/import"
require "main/view"

module Main
  module Views
    module Pages
      class About < Main::View
        include Main::Import(
          "main.persistence.repositories.people"
        )

        configure do |config|
          config.template = "pages/about"
        end

        def locals(options = {})
          super.merge(
            people: people.for_about_page,
          )
        end
      end
    end
  end
end
