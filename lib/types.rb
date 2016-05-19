require "dry-types"

module Types
  include Dry::Types.module

  PostHighlightColor = Types::Strict::String.enum("blue", "yellow", "red")
end
