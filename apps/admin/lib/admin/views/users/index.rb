require "admin/import"
require "admin/view"

module Admin
  module Views
    module Users
      class Index < Admin::View
        include Admin::Import("admin.persistence.repositories.users")

        configure do |config|
          config.template = "users/index"
        end

        def locals(options = {})
          super.merge(
            current_user: options[:scope].current_user, users: users.listing
          )
        end
      end
    end
  end
end
