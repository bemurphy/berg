require "admin/import"
require "admin/view"

module Admin
  module Views
    module Categories
      class Index < Admin::View
        include Admin::Import("admin.persistence.repositories.categories")

        configure do |config|
          config.template = "categories/index"
        end

        def locals(options = {})
          super.merge(
            categories: categories.listing
          )
        end
      end
    end
  end
end
