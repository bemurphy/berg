require "types"

module Admin
  module Entities
    class Post < Dry::Types::Value
      Status = Types::Strict::String.default("draft").enum("draft", "published", "deleted")

      attribute :id, Types::Strict::Int
      attribute :title, Types::Strict::String
      attribute :body, Types::String
      attribute :slug, Types::Strict::String
      attribute :status, Status
      attribute :author_id, Types::Strict::Nil | Dry::Types["admin.entities.user"]
      attribute :published_at, Types::DateTime
    end
  end
end
