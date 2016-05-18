require "admin_app_helper"

RSpec.feature "Admin / Projects / Create", js: true do
  include_context "admin users"

  background do
    sign_in(jane.email, jane.password)
  end

  scenario "I can create a project" do
    find("nav a", text: "Projects").trigger("click")

    find("a", text: "Add a project").trigger("click")

    find("#title").set("An Example Project")
    find("#client").set("An example client")
    find("#url").set("http://example.com")
    find("#intro").set("Intro text for this example project")
    find("#body").set("Body content for this example project")
    find("#tags").set("examplepost")

    find("button", text: "Create project").trigger("click")

    expect(page).to have_content("Project has been created")

    expect(page).to have_content("An Example Project")
  end

  scenario "I can see validation errors" do
    find("nav a", text: "Projects").trigger("click")

    find("a", text: "Add a project").trigger("click")

    find("#title").set("")
    find("#client").set("An example client")
    find("#url").set("http://example.com")
    find("#intro").set("Intro text for this example project")
    find("#body").set("Body content for this example project")
    find("#tags").set("examplepost")

    find("button", text: "Create project").trigger("click")

    expect(page).to have_content("must be filled")
  end
end
