require "berg/repository"
require "admin/entities/tagging"

module Admin
  module Persistence
    module Repositories
      class Taggings < Berg::Repository[:taggings]
        commands :create, :destroy

        def [](id)
          taggings.by_id(id).as(Entities::Tagging).one
        end

        def listing
          taggings
            .as(Entities::Tagging)
        end
      end
    end
  end
end
