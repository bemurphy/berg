module Persistence
  module Commands
    class UpdatePost < ROM::Commands::Update[:sql]
      relation :posts
      register_as :update
      result :one

      def execute(tuple)
        result = super

        post_id = result.first[:id]
        categorisations.where(post_id: post_id).delete

        if tuple[:post_categories]
          categories = tuple[:post_categories].product([post_id])

          post_tupples = categories.map do |category_id, post_id|
            {
              category_id: category_id,
              post_id: post_id
            }
          end

          categorisations.multi_insert(post_tupples)
        end

        result
      end

      private

      def categorisations
        relation.categorisations
      end
    end
  end
end
