require "types"

module Admin
  module Entities
    class User < Dry::Types::Value
      attribute :id, Types::Strict::Int
      attribute :name, Types::Strict::String
      attribute :email, Types::Strict::String
      attribute :encrypted_password, Types::Strict::String
    end
  end
end
