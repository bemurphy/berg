module Persistence
  module Commands
    class UpdateHomePageFeaturedProjects < ROM::Commands::Update[:sql]
      relation :home_page_featured_projects
      register_as :update
      result :many

      def execute(tuple)
        if tuple[:home_page_featured_projects]
          home_page_featured_projects.delete

          home_page_featured_projects_tuples = tuple[:home_page_featured_projects].each_with_index.map do |project_id, position|
            {
              project_id: project_id,
              position: position
            }
          end

          home_page_featured_projects.multi_insert(home_page_featured_projects_tuples)
        end
      end

      private

      def home_page_featured_projects
        relation.home_page_featured_projects
      end
    end
  end
end
