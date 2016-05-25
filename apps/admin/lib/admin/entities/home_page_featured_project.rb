require "types"

module Admin
  module Entities
    class HomePageFeaturedProject < Dry::Types::Value
      attribute :id, Types::Strict::Int
      attribute :project_id, Types::Strict::Int
      attribute :position, Types::Strict::Int
    end
  end
end
