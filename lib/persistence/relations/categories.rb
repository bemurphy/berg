module Persistence
  module Relations
    class Categories < ROM::Relation[:sql]
      schema(:categories) do
        attribute :id, Types::Serial
        attribute :name, Types::Strict::String
        attribute :slug, Types::Strict::String

        associate do
          many :posts, through: :categorisations
        end
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
