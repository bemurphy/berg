require "bcrypt"

module Authentication
  class EncryptPassword
    include BCrypt

    def call(input)
      Password.create(input)
    end

    def same?(hash, password)
      return false if hash.nil?

      Password.new(hash) == password
    end
  end
end
