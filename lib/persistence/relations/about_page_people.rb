module Persistence
  module Relations
    class AboutPagePeople < ROM::Relation[:sql]
      schema(:about_page_people) do
        attribute :person_id, Types::ForeignKey(:people)
        attribute :position, Types::Strict::Int

        associate do
          belongs :person, relation: :people
        end
      end
    end
  end
end
