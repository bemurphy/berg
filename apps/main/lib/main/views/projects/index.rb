require "main/decorators/public_project"
require "main/import"
require "main/view"

module Main
  module Views
    module Projects
      class Index < Main::View
        include Main::Import("main.persistence.repositories.projects")

        configure do |config|
          config.template = "projects/index"
        end

        def locals(options = {})
          public_projects = projects.listing.to_a.map { |a| Decorators::PublicProject.new(a) }

          super.merge(
            projects: public_projects.to_a
          )
        end
      end
    end
  end
end
