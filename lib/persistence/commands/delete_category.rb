module Persistence
  module Commands
    class DeleteCategory < ROM::Commands::Delete[:sql]
      relation :categories
      register_as :delete
      result :one

      def execute(tuple)
        result = super

        catgeory_id = result.first[:id]
        categorisations.where(catgeory_id: catgeory_id).delete

        result
      end

      private

      def categorisations
        relation.categorisations
      end
    end
  end
end
