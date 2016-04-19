require "either_result_matcher"

module Authentication
  class Authenticate
    include EitherResultMatcher.for(:call)

    def call(attributes)
      email, password = attributes.values_at("email", "password")
      entity = fetch(email)

      if entity && encrypt_password.same?(entity.encrypted_password, password)
        Right(entity)
      else
        Left(:user_not_found)
      end
    end

    def fetch(email)
      raise NotImplementedError
    end
  end
end
