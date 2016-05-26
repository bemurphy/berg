module Persistence
  module Commands
    class CreateCategory < ROM::Commands::Create[:sql]
      relation :categories
      register_as :create
      result :one
    end
  end
end
