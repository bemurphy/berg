require "dry-types"

module Types
  include Dry::Types.module

  PostHighlightColor = Types::Strict::String.enum("red", "orange", "yellow","green", "blue", "indigo", "violet")
end
