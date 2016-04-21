require "securerandom"

module Admin
  module Users
    class AccessToken
      def value
        SecureRandom.hex
      end

      def expires_at
        DateTime.now + 2
      end
    end
  end
end
