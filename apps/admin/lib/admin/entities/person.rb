require "types"

module Admin
  module Entities
    class Person < Dry::Types::Value
      attribute :id, Types::Strict::Int
      attribute :first_name, Types::Strict::String
      attribute :last_name, Types::Strict::String
      attribute :email, Types::Strict::String
      attribute :active, Types::Strict::Bool

      alias_method :active?, :active

      def full_name
        "#{first_name} #{last_name}"
      end
    end
  end
end
