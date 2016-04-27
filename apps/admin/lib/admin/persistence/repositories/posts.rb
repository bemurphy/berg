require "berg/repository"
require "admin/entities/post"

module Admin
  module Persistence
    module Repositories
      class Posts < Berg::Repository[:posts]
        commands :create, update: [:by_id, :by_slug]

        alias_method :update, :update_by_id

        def [](id)
          posts.by_id(id).as(Entities::Post).one
        end

        def by_slug(slug)
          posts.by_slug(slug).as(Entities::Post).one
        end

        def listing
          posts.as(Entities::Post).to_a
        end
      end
    end
  end
end