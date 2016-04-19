require "berg/repository"
require "admin/entities/user"

module Admin
  module Persistence
    module Repositories
      class Users < Berg::Repository[:users]
        commands :create, update: [:by_id, :by_email]

        alias_method :update, :update_by_id

        def [](id)
          users.by_id(id).as(Entities::User).one
        end

        def by_email(email)
          users.by_email(email).as(Entities::User).one
        end
      end
    end
  end
end
