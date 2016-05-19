require "dry-types"

module Types
  include Dry::Types.module

  Color = Types::Strict::String.enum("blue", "yellow", "red")
end
