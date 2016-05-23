module Persistence
  module Relations
    class Users < ROM::Relation[:sql]
      schema(:users) do
        attribute :id, Types::Serial
        attribute :email, Types::String
        attribute :first_name, Types::String
        attribute :last_name, Types::String
        attribute :bio, Types::Strict::String.optional
        attribute :short_bio, Types::Strict::String.optional
        attribute :website, Types::Strict::String.optional
        attribute :twitter, Types::Strict::String.optional
        attribute :job_title, Types::Strict::String.optional
        attribute :encrypted_password, Types::String
        attribute :active, Types::Bool
        attribute :access_token, Types::String
        attribute :access_token_expiration, Types::Time
      end

      def by_id(id)
        where(id: id)
      end

      def by_email(email)
        where(email: email)
      end

      def by_access_token(token)
        where(access_token: token)
      end

      def active
        where(active: true)
      end
    end
  end
end
