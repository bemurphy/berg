module Persistence
  module Commands
    class CreateCategorisation < ROM::Commands::Create[:sql]
      relation :categorisations
      register_as :create
      result :one

      def execute(tuple)
        result = super
        categorisations.insert(tuple)

        result
      end

      private

      def categorisations
        relation.categorisations
      end
    end
  end
end
