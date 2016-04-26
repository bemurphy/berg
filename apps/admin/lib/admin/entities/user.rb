require "types"

module Admin
  module Entities
    class User < Dry::Types::Value
      attribute :id, Types::Strict::Int
      attribute :name, Types::Strict::String
      attribute :email, Types::Strict::String
      attribute :encrypted_password, Types::Strict::String
      attribute :access_token, Types::String
      attribute :access_token_expiration, Types::DateTime
      attribute :active, Types::Bool
    end
  end
end
