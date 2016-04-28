require "admin_app_helper"

RSpec.feature "Admin / Sign-in", js: true do
  include_context "admin users"

  scenario "I see user index after signing-in" do
    sign_in(jane.email)

    find("nav a", text: "Users").trigger("click")

    expect(page).to have_content("Users")

    within("table") do
      expect(page).to have_content(jane.email)
    end
  end

  scenario "I see a warning about default password" do
    sign_in(jane.email)

    expect(page).to have_content("You need to change your password")
  end

  scenario "I can sign-out from admin" do
    sign_in(jane.email)

    find("nav a", text: "Log out").trigger("click")

    expect(page).to have_content("Sign in")
  end

  context "as a deactivated user" do
    let!(:john) { create_deactivated_user("John") }

    scenario "I can't login and see info message" do
      sign_in(john.email)

      expect(page).to have_content("Your account is not active")
    end
  end
end
