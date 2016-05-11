require "berg/repository"
require "admin/entities/tag"

module Admin
  module Persistence
    module Repositories
      class Tags < Berg::Repository[:tags]
        commands :create

        def [](id)
          tags.by_id(id).as(Entities::Tag).one
        end

        def listing
          tags
            .order(:name)
            .as(Entities::Tag)
        end
      end
    end
  end
end
