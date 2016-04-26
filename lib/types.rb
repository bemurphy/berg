require "dry-types"

module Types
  include Dry::Types.module

  Password = Types::Strict::String.default("changeme")
end
