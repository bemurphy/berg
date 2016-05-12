module Persistence
  module Commands
    class CreatePost < ROM::Commands::Create[:sql]
      relation :posts
      register_as :create
      result :one
    end
  end
end
