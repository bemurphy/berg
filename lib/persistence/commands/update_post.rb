module Persistence
  module Commands
    class UpdatePost < ROM::Commands::Update[:sql]
      relation :posts
      register_as :update
      result :one

      def execute(tuple)
        result = super

        post_id = relation.first[:id]
        taggings.where(post_id: post_id).delete

        if tuple[:post_tags]
          tags = tuple[:post_tags].product([post_id])

          post_tupples = tags.map do |tag_id, post_id|
            {
              tag_id: tag_id,
              post_id: post_id
            }
          end

          taggings.multi_insert(post_tupples)
        end

        result
      end

      private

      def taggings
        relation.taggings
      end
    end
  end
end
