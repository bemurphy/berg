require "admin_app_helper"

RSpec.feature "Admin / Users / Edit", js: true do
  include_context "admin users"

  background do
    sign_in(jane.email)
  end

  scenario "I can edit a user" do
    find("nav a", text: "Users").trigger("click")

    within("#user-#{john.id}") {
      find("a", text: "Edit").trigger("click")
    }

    find("#email").set("james@doe.org")

    find("button", text: "Save changes").trigger("click")

    expect(page).to have_content("User has been updated")

    find("nav a", text: "Users").trigger("click")

    expect(page).to have_content("james@doe.org")
  end

  scenario "I can see validation errors" do
    find("nav a", text: "Users").trigger("click")

    within("#user-#{john.id}") {
      find("a", text: "Edit").trigger("click")
    }

    find("#email").set("")

    find("button", text: "Save changes").trigger("click")

    expect(page).to have_content("must be filled")
  end

  scenario "I can change password of a user" do
    find("nav a", text: "Users").trigger("click")

    within("#user-#{jane.id}") {
      find("a", text: "Change password").trigger("click")
    }

    find("#password").set("super-secret")

    click_on("Change password")

    expect(page).to have_content("Password has been changed")

    find("nav a", text: "Users").trigger("click")

    expect(page).to_not have_content("You need to change your password")
  end

  scenario "I can see validation errors for an invalid password" do
    find("nav a", text: "Users").trigger("click")

    within("#user-#{jane.id}") {
      find("a", text: "Change password").trigger("click")
    }

    find("#password").set("")

    click_on("Change password")

    expect(page).to have_content("size cannot be less than 8")
  end

  scenario "I can deactivate a user" do
    find("nav a", text: "Users").trigger("click")

    within("#user-#{john.id}") {
      find("a", text: "Edit").trigger("click")
    }

    uncheck("active")

    find("button", text: "Save changes").trigger("click")

    expect(page).to have_content("User has been updated")

    find("nav a", text: "Users").trigger("click")

    within("#user-#{john.id}") { expect(page).to have_content("Deactivated") }
  end
end
