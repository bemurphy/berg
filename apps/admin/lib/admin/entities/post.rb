require "types"

module Admin
  module Entities
    class Post < Dry::Types::Value
      attribute :id, Types::Strict::Int
      attribute :title, Types::Strict::String
      attribute :body, Types::String
      attribute :slug, Types::Strict::String
      attribute :state, Types::String
      attribute :author_id, Types::Int
      attribute :published_at, Types::DateTime
    end
  end
end
