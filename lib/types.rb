require "dry-types"

module Types
  include Dry::Types.module

  Colour = Types::Strict::String.default("blue").enum("blue", "yellow", "red")
end
