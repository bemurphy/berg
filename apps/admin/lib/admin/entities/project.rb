require "types"

module Admin
  module Entities
    class Project < Dry::Types::Value
      attribute :id, Types::Serial
      attribute :title, Types::String
      attribute :slug, Types::String
      attribute :intro, Types::Text
      attribute :url, Types::String
      attribute :client, Types::String
      attribute :body, Types::Text
      attribute :tags, Types::String
    end
  end
end
