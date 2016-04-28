require "admin_app_helper"

RSpec.feature "Admin / Users / Activation", js: true do
  include_context "admin users"

  scenario "I can activate my account by setting my password" do
    visit("/admin/users/update-password/#{jane.access_token}")

    find("#password").set("super-secret")
    find("button", text: "Save").trigger("click")

    find(".nav-list__link", text: "Users").trigger("click")

    expect(page).to have_content("#{jane.email}")
  end

  scenario "I see validation errors when password was invalid" do
    visit("/admin/users/update-password/#{jane.access_token}")

    find("#password").set("ab")
    find("button", text: "Save").trigger("click")

    expect(page).to have_content("size cannot be less than 8")
  end

  scenario "I am redirected to sign-in page when token is not valid" do
    visit("/admin/users/update-password/not-good")

    expect(page).to have_content("Token is invalid or expired")
    expect(page).to have_content("Sign in")
  end
end
