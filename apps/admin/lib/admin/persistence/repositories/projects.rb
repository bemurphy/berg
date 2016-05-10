require "berg/repository"
require "admin/entities/project"

module Admin
  module Persistence
    module Repositories
      class Users < Berg::Repository[:projects]
        commands :create, update: [:by_id, :by_slug]

        alias_method :update, :update_by_id

        def [](id)
          projects.by_id(id).as(Entities::Project).one
        end

        def by_slug(slug)
          projects.by_slug(slug).as(Entities::Project).one
        end

        def listing
          projects.as(Entities::Project).to_a
        end
      end
    end
  end
end
