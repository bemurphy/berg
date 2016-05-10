require "admin/import"
require "admin/paginator"
require "admin/view"

module Admin
  module Views
    module Projects
      class Index < Admin::View
        include Admin::Import("admin.persistence.repositories.projects")

        configure do |config|
          config.template = "projects/index"
        end

        def locals(options = {})
          options = { per_page: 20, page: 1 }.merge(options)
          all_projects = projects.listing(page: options[:page], per_page: options[:per_page])

          super.merge(
            projects: all_projects.to_a,
            paginator: Paginator.new(all_projects.pager, url_template: "/admin/projects?page=%")
          )
        end
      end
    end
  end
end
