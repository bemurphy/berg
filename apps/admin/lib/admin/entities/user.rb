require "types"

module Admin
  module Entities
    class User < Dry::Types::Value
      attribute :id, Types::Strict::Int
      attribute :first_name, Types::Strict::String
      attribute :last_name, Types::Strict::String
      attribute :email, Types::Strict::String
      attribute :encrypted_password, Types::Nil | Types::Strict::String
      attribute :access_token, Types::String
      attribute :access_token_expiration, Types::DateTime
      attribute :active, Types::Bool
      attribute :bio, Types::Nil | Types::Strict::String
      attribute :website, Types::Nil | Types::Strict::String
      attribute :twitter, Types::Nil | Types::Strict::String

      alias_method :active?, :active

      def full_name
        "#{first_name} #{last_name}"
      end
    end
  end
end
