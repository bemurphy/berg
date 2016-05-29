require "main/import"
require "main/view"

module Main
  module Views
    module Pages
      class Home < Main::View
        include Main::Import("main.persistence.repositories.home_page_featured_items")

        configure do |config|
          config.template = "pages/home"
        end

        def locals(options = {})
          super.merge(
            featured_items: home_page_featured_items.listing_by_position
          )
        end
      end
    end
  end
end
