require "main/import"
require "main/view"
require "main/decorators/public_person"

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
            people: Decorators::PublicPerson.decorate(people.for_about_page),
          )
        end
      end
    end
  end
end
