module Persistence
  module Commands
    class UpdateProject < ROM::Commands::Update[:sql]
      relation :projects
      register_as :update
      result :one
    end
  end
end
