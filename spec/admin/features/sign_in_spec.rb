require "admin_app_helper"

RSpec.feature "Admin / Sign-in", js: true do
  include_context "admin users"

  scenario "I see user index after signing-in" do
    sign_in(jane.email, jane.password)

    find("nav a", text: "Users").trigger("click")

    expect(page).to have_content("Users")

    within("table") do
      expect(page).to have_content(jane.email)
    end
  end

  scenario "I can sign-out from admin" do
    sign_in(jane.email, jane.password)

    find("nav a", text: "Log out").trigger("click")

    expect(page).to have_content("Sign in")
  end

  context "as a deactivated user" do
    let!(:john) { create_deactivated_user(name: "John", password: "password123") }

    scenario "I can't sign in" do
      sign_in(john.email, john.password)

      expect(page).to have_content("Email or password is incorrect")
    end
  end
end
