module Persistence
  module Commands
    class UpdateAboutPagePeople < ROM::Commands::Update[:sql]
      relation :about_page_people
      register_as :update
      result :many

      def execute(tuple)
        if tuple[:about_page_people]
          about_page_people.delete

          about_page_people_tuples = tuple[:about_page_people].map.with_index do |person_id, position|
            {
              person_id: person_id,
              position: position
            }
          end

          about_page_people.multi_insert(about_page_people_tuples)
        end
      end

      private

      def about_page_people
        relation.about_page_people
      end
    end
  end
end
