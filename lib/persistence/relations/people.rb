module Persistence
  module Relations
    class People < ROM::Relation[:sql]
      schema(:people) do
        attribute :id, Types::Serial
        attribute :first_name, Types::Strict::String
        attribute :last_name, Types::Strict::String
        attribute :email, Types::Strict::String
        attribute :bio, Types::Strict::String
        attribute :twitter, Types::Strict::String.optional
        attribute :website, Types::Strict::String.optional
        attribute :avatar, Types::Strict::String.optional
        attribute :job_title, Types::Strict::String.optional
      end

      use :pagination
      per_page 20

      def by_id(id)
        where(id: id)
      end

      def for_about_page
        select
          .inner_join(
            :about_page_people,
            person_id: :id)
          .where(active: true)
          .order(:position)
      end
    end
  end
end
