require "berg/repository"
require "admin/entities/category"

module Admin
  module Persistence
    module Repositories
      class Categories < Berg::Repository[:categories]
        commands :create

        def [](id)
          categories.by_id(id).as(Entities::Category).one
        end

        def by_slug(slug)
          categories
            .by_slug(slug)
            .as(Entities::Category).one
        end

        def slug_exists?(slug)
          !!categories.matching_slugs(slug).one
        end

        def listing
          categories
            .order(:name)
            .as(Entities::Category)
        end
      end
    end
  end
end
