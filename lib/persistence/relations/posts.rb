module Persistence
  module Relations
    class Posts < ROM::Relation[:sql]
      schema(:posts) do
        attribute :id, Types::Serial
        attribute :title, Types::String
        attribute :content, Types::String
        attribute :slug, Types::String
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
