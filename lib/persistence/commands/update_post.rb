module Persistence
  module Commands
    class UpdatePost < ROM::Commands::Update[:sql]
      relation :posts
      register_as :update
      result :one

      def execute(tuple)
        result = super
        if tuple[:tag_ids]
          post_id = relation.first[:id]
          tags = tuple[:tag_ids].product([post_id])

          taggings.where(post_id: post_id).delete

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
