require "admin_app_helper"

RSpec.feature "Admin / Sign-in / Password Reset" do
  include_context "admin users"

  scenario "I can ask for a reset-password email" do
    visit("/admin/sign-in")

    click_on "Forgot your password?"

    find("#email").set("jane@doe.org")
    click_on "Submit"

    expect(page).to have_content("Check your email for password reset instructions")
  end
end
