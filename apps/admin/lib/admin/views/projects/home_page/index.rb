require "admin/import"
require "admin/paginator"
require "admin/view"

module Admin
  module Views
    module Projects
      module HomePage
        class Index < Admin::View
          include Admin::Import("admin.persistence.repositories.home_page_featured_projects")

          configure do |config|
            config.template = "projects/home_page/index"
          end

          def locals(options = {})
            super.merge(
              home_page_featured_projects: home_page_featured_projects.listing
            )
          end
        end
      end
    end
  end
end
