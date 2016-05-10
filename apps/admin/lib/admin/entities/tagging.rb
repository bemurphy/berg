require "types"

module Admin
  module Entities
    class Tagging < Dry::Types::Value
      attribute :id, Types::Strict::Int
      attribute :post_id, Types::Strict::Int
      attribute :tag_id, Types::Strict::Int
    end
  end
end
