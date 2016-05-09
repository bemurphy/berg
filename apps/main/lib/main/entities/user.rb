require "types"

module Main
  module Entities
    class User < Dry::Types::Value
      attribute :id, Types::Strict::Int
      attribute :first_name, Types::Strict::String
      attribute :last_name, Types::Strict::String
      attribute :email, Types::Strict::String

      def full_name
        "#{first_name} #{last_name}"
      end
    end
  end
end
