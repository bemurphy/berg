require "types"

module Admin
  module Entities
    class Post < Dry::Types::Value
      attribute :id, Types::Strict::Int
      attribute :title, Types::Strict::String
      attribute :content, Types::Strict::String
      attribute :slug, Types::Strict::String
    end
  end
end
