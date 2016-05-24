require "main/import"
require "main/view"

module Main
  module Views
    module Projects
      class Show < Main::View
        include Main::Import("main.persistence.repositories.projects")

        configure do |config|
          config.template = "projects/show"
        end

        def locals(options = {})
          super.merge(
            project: projects.by_slug(options[:slug])
          )
        end
      end
    end
  end
end
