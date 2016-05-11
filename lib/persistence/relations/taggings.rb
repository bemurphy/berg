module Persistence
  module Relations
    class Taggings < ROM::Relation[:sql]
      schema(:taggings) do
        attribute :id, Types::Serial
        attribute :post_id, Types::ForeignKey(:posts)
        attribute :tag_id, Types::ForeignKey(:tags)

        associate do
          belongs :tags
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
