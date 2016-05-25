module Persistence
  module Commands
    class CreatePerson < ROM::Commands::Create[:sql]
      relation :people
      register_as :create
      result :one
    end
  end
end
