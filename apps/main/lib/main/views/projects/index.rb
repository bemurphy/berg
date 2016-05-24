require "main/import"
require "main/paginator"
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
          page      = options[:page] || 1
          per_page  = options[:per_page] || 20

          all_projects = projects.listing(page: page, per_page: per_page)

          super.merge(
            projects: all_projects,
            paginator: Paginator.new(all_projects.pager, url_template: "/projects?page=%")
          )
        end
      end
    end
  end
end
