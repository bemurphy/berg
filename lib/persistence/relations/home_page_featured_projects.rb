module Persistence
  module Relations
    class HomePageFeaturedProjects < ROM::Relation[:sql]
      schema(:home_page_featured_projects) do
        attribute :project_id, Types::ForeignKey(:projects)
        attribute :position, Types::Int

        associate do
          belongs :project
        end
      end
    end
  end
end
