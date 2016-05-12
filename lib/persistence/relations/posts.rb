module Persistence
  module Relations
    class Posts < ROM::Relation[:sql]
      schema(:posts) do
        attribute :id, Types::Serial
        attribute :title, Types::String
        attribute :teaser, Types::String
        attribute :body, Types::String
        attribute :slug, Types::String
        attribute :status, Types::String
        attribute :author_id, Types::Serial
        attribute :published_at, Types::Time
      end

      use :pagination

      def by_id(id)
        where(id: id)
      end

      def by_slug(slug)
        where(slug: slug)
      end

      def matching_slugs(slug)
        select(:slug).by_slug(slug)
      end

      def published
        where(status: "published")
      end
    end
  end
end
