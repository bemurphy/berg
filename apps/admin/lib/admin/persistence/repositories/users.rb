require "icelab_com_au/repository"
require "admin/entities/user"

module Admin
  module Persistence
    module Repositories
      class Users < IcelabComAu::Repository[:users]
        commands :create

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
