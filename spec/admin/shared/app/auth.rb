# TODO: we need fixtures

require "ostruct"

RSpec.shared_context "admin auth" do
  def create_user(attrs = {})
    name = attrs.fetch(:name)

    access_token = Admin::Container["admin.users.access_token"]

    result = Admin::Container["admin.persistence.repositories.users"].create(
      email: "#{name.downcase}@doe.org",
      first_name: name,
      last_name: "Doe",
      active: attrs.fetch(:active) { true },
      encrypted_password: Admin::Container["core.authentication.encrypt_password"].(attrs.fetch(:password)),
      access_token: access_token.value,
      access_token_expiration: access_token.expires_at,
    )

    OpenStruct.new(result.to_h.merge(password: attrs[:password]))
  end

  def create_deactivated_user(attrs = {})
    create_user(attrs.merge(active: false))
  end

  def sign_in(email, password)
    visit "/admin/sign-in"

    find("#user-email").set(email)
    find("#user-password").set(password)

    click_on "Sign in"
  end
end

RSpec.shared_context "admin users" do
  include_context "admin auth"

  let!(:jane) { create_user(name: "Jane", password: "password123") }
  let!(:john) { create_user(name: "John", password: "password123") }
end
