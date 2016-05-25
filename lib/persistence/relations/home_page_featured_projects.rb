module Persistence
  module Relations
    class HomePageFeaturedProjects < ROM::Relation[:sql]
      schema(:home_page_featured_projects) do
        attribute :id, Types::Serial
        attribute :project_id, Types::Int
        attribute :position, Types::Int
      end

      def by_id(id)
        where(id: id)
      end
    end
  end
end
