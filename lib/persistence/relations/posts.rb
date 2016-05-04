module Persistence
  module Relations
    class Posts < ROM::Relation[:sql]
      schema(:posts) do
        attribute :id, Types::Serial
        attribute :title, Types::String
        attribute :body, Types::String
        attribute :slug, Types::String
        attribute :state, Types::String
        attribute :author_id, Types::Serial
        attribute :published_at, Types::DateTime
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
