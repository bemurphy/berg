require "admin_app_helper"

RSpec.feature "Admin / Projects / Edit", js: true do
  include_context "admin users"
  include_context "admin projects"

  background do
    sign_in(jane.email, jane.password)
  end

  scenario "I can edit a project, and change the slug" do
    find("nav a", text: "Projects").trigger("click")

    within("#project-#{sample_project.slug}") {
      find("a", text: "#{sample_project.title}").trigger("click")
    }

    find("#title").set("A new title")
    find("#slug").set("a-new-title")

    find("button", text: "Save changes").trigger("click")

    expect(page).to have_content("Project has been updated")

    expect(page).to have_content("A new title")
  end

  scenario "I can see validation errors" do
    find("nav a", text: "Projects").trigger("click")

    within("#project-#{sample_project.slug}") {
      find("a", text: "#{sample_project.title}").trigger("click")
    }

    find("#title").set("")

    find("button", text: "Save changes").trigger("click")

    expect(page).to have_content("must be filled")
  end
end
