RSpec.shared_context "admin auth" do
  def create_user(name, attrs = {})
    # TODO: we need fixtures
    Admin::Container["admin.users.operations.create"].({
      "email" => "#{name.downcase}@doe.org",
      "first_name" => name,
      "last_name" => "Doe",
      "password" => Types::Password.value,
      "active" => true
    }.merge(attrs)).value
  end

  def create_deactivated_user(name)
    create_user(name, "active" => false)
  end

  def sign_in(email, password = Types::Password.value)
    visit "/admin/sign-in"

    find("#user-email").set(email)
    find("#user-password").set(password)

    click_on "Sign in"
  end
end

RSpec.shared_context "admin users" do
  include_context "admin auth"

  let!(:jane) { create_user("Jane") }
  let!(:john) { create_user("John") }
end
