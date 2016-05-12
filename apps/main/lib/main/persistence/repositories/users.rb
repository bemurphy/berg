require "berg/repository"
require "main/entities/user"

module Main
  module Persistence
    module Repositories
      class Users < Berg::Repository[:users]
        def [](id)
          users.by_id(id).as(Entities::User).one
        end
      end
    end
  end
end
