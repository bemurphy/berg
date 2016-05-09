require "types"
require "main/entities/user"

module Main
  module Entities
    class Post < Dry::Types::Value
      Status = Types::Strict::String.default("draft").enum("draft", "published", "deleted")

      attribute :id, Types::Strict::Int
      attribute :title, Types::Strict::String
      attribute :body, Types::String
      attribute :slug, Types::Strict::String
      attribute :status, Status
      attribute :author_id, Types::Int
      attribute :published_at, Types::DateTime

      class WithAuthor < Post
        attribute :author, "main.entities.user"
      end
    end
  end
end
