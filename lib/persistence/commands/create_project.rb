module Persistence
  module Commands
    class CreateProject < ROM::Commands::Create[:sql]
      relation :projects
      register_as :create
      result :one
    end
  end
end
