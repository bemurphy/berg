require "types"
require "admin/entities/category"

module Admin
  module Entities
    class Post < Dry::Types::Value
      Status = Types::Strict::String.default("draft").enum("draft", "published", "deleted")

      attribute :id, Types::Strict::Int
      attribute :title, Types::Strict::String
      attribute :teaser, Types::Strict::String
      attribute :body, Types::Strict::String
      attribute :slug, Types::Strict::String
      attribute :status, Status
      attribute :person_id, Types::Strict::Int
      attribute :published_at, Types::Time

      def deleted?
        status == "deleted"
      end

      def published?
        status == "published"
      end
    end

    class PostWithCategories < Post
      attribute :post_categories, Types::Strict::Array.member(Admin::Entities::Category)
    end
  end
end
