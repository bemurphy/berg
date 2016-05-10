module Persistence
  module Relations
    class Tags < ROM::Relation[:sql]
      schema(:tags) do
        attribute :id, Types::Serial
        attribute :name, Types::Strict::String
        attribute :slug, Types::Strict::String
      end

      def by_id(id)
        where(id: id)
      end

      def by_slug(slug)
        where(slug: slug)
      end

      def matching_slugs(slug)
        select(:slug).by_slug(slug)
      end
    end
  end
end
