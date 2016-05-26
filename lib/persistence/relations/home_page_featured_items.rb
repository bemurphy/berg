module Persistence
  module Relations
    class HomePageFeaturedItems < ROM::Relation[:sql]
      schema(:home_page_featured_items) do
        attribute :id, Types::Serial
        attribute :position, Types::Int
        attribute :title, Types::String
        attribute :description, Types::String
        attribute :url, Types::String
        attribute :image_id, Types::String
      end
    end
  end
end
