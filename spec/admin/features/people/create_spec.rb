require "admin_app_helper"

RSpec.feature "Admin / People / Create", js: true do
  include_context "admin users"

  background do
    sign_in(jane.email, jane.password)
  end

  scenario "I can create a person" do
    find("nav a", text: "People").trigger("click")

    find("a", text: "Add a person").trigger("click")

    find("#first_name").set("John")
    find("#last_name").set("Doe")
    find("#email").set("john.doe@icelab.com.au")
    find("#bio").set("A simple bio")
    find("#short_bio").set("A Short bio")

    find("button", text: "Create person").trigger("click")

    expect(page).to have_content("Person has been created")

    expect(page).to have_content("John Doe")
  end

  scenario "I can see validation errors" do
    find("nav a", text: "People").trigger("click")

    find("a", text: "Add a person").trigger("click")

    find("#first_name").set("John")
    find("#last_name").set("Doe")
    find("#bio").set("A simple bio")
    find("#short_bio").set("A short bio")

    find("button", text: "Create person").trigger("click")

    expect(page).to have_content("must be filled")
  end
end
