module Persistence
  module Relations
    class Categorisations < ROM::Relation[:sql]
      schema(:categorisations) do
        attribute :id, Types::Serial
        attribute :post_id, Types::ForeignKey(:posts)
        attribute :category_id, Types::ForeignKey(:categories)

        associate do
          belongs :categories
          belongs :posts
        end
      end

      def by_id(id)
        where(id: id)
      end

      def by_post_id(id)
        where(post_id: id)
      end

      def matching_slugs(slug)
        select(:slug).by_slug(slug)
      end
    end
  end
end
