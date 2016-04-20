module Persistence
  module Relations
    class Users < ROM::Relation[:sql]
      dataset :users
      register_as :users

      def by_id(id)
        where(id: id)
      end

      def by_email(email)
        where(email: email)
      end
    end
  end
end
