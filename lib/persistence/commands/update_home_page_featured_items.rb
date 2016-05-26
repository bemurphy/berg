module Persistence
  module Commands
    class UpdateHomePageFeaturedItems < ROM::Commands::Update[:sql]
      relation :home_page_featured_items
      register_as :update
      result :many

      def execute(tuple)
        if tuple[:home_page_featured_items]
          home_page_featured_items.delete

          home_page_featured_items_tuples = tuple[:home_page_featured_items].each_with_index.map do |item, position|
            {
              position: position,
              title: item[:title],
              description: item[:description],
              url: item[:url],
              image_id: item[:image_id]
            }
          end

          home_page_featured_items.multi_insert(home_page_featured_items_tuples)
        end
      end

      private

      def home_page_featured_items
        relation.home_page_featured_items
      end
    end
  end
end
