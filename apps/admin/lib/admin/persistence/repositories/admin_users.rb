require "admin/entities/admin_user"

module Admin
  module Persistence
    module Repositories
      class AdminUsers < ROM::Repository
        relations :admin_users

        def [](id)
          admin_users.by_id(id).as(Entities::AdminUser).one
        end

        def by_email(email)
          admin_users.by_email(email).as(Entities::AdminUser).one
        end
      end
    end
  end
end
