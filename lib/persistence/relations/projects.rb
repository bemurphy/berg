module Persistence
  module Relations
    class Projects < ROM::Relation[:sql]
      schema(:projects) do
        attribute :id, Types::Serial
        attribute :title, Types::String
        attribute :client, Types::String
        attribute :url, Types::String
        attribute :intro, Types::Text
        attribute :body, Types::Text
        attribute :tags, Types::String
        attribute :slug, Types::String
        attribute :status, Types::String
      end

      def by_id(id)
        where(id: id)
      end

      def by_slug(slug)
        where(slug: slug)
      end
    end
  end
end
