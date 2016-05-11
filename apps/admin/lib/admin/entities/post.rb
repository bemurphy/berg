require "types"
require "admin/entities/tag"

module Admin
  module Entities
    class Post < Dry::Types::Value
      Status = Types::Strict::String.default("draft").enum("draft", "published", "deleted")

      attribute :id, Types::Strict::Int
      attribute :title, Types::Strict::String
      attribute :teaser, Types::String
      attribute :body, Types::String
      attribute :slug, Types::Strict::String
      attribute :status, Status
      attribute :author_id, Types::Int
      attribute :published_at, Types::DateTime
    end

    class PostWithTags < Post
      attribute :post_tags, "array<admin.entities.tag>"
    end
  end
end
