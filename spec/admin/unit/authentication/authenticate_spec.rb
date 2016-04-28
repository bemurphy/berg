require "db_helper"
require "admin/authentication/authenticate"
require "admin/entities/user"

RSpec.describe Admin::Authentication::Authenticate do
  subject(:authenticate) do
    Admin::Authentication::Authenticate.new(encrypt_password, users_repo)
  end

  let(:encrypt_password) { instance_double(Authentication::EncryptPassword) }
  let(:users_repo) { instance_double(Admin::Persistence::Repositories::Users, by_email: user) }

  let(:input) { { "email" => "jane@doe.org", "password" => "foo" } }

  context "user exists" do
    let(:user) { instance_double(Admin::Entities::User, encrypted_password: "xyz") }

    it "returns the user if the password matches" do
      expect(encrypt_password).to receive(:same?).with("xyz", "foo").and_return true
      expect(authenticate.(input).value).to eq user
    end

    it "returns error if the password doesn't match" do
      expect(encrypt_password).to receive(:same?).with("xyz", "foo").and_return false

      expect(authenticate.(input).value).to be(:user_not_found)
    end
  end

  context "user doesn't exist" do
    let(:user) { nil }

    it "returns nil" do
      expect(authenticate.(input).value).to be(:user_not_found)
    end
  end
end
