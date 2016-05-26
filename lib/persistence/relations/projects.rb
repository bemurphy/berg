module Persistence
  module Relations
    class Projects < ROM::Relation[:sql]
      schema(:projects) do
        attribute :id, Types::Serial
        attribute :title, Types::String
        attribute :client, Types::String
        attribute :url, Types::String
        attribute :intro, Types::String
        attribute :body, Types::String
        attribute :tags, Types::String
        attribute :slug, Types::String
        attribute :status, Types::String
        attribute :published_at, Types::DateTime
        attribute :case_study, Types::Bool
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
    end
  end
end
