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
          options = { per_page: 20, page: 1 }.merge(options)
          all_projects = projects.listing(page: options[:page], per_page: options[:per_page])

          public_projects = all_projects.to_a.map { |a|
            Decorators::PublicProject.new(a)
          }

          super.merge(
            projects: public_projects,
            paginator: all_projects.pager
          )
        end
      end
    end
  end
end
