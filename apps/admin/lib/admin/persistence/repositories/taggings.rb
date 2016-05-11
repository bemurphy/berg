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

        def by_post_id(post_id)
          taggings.by_post_id(post_id).as(Entities::Tagging)
        end

        def listing
          taggings
            .as(Entities::Tagging)
        end
      end
    end
  end
end
