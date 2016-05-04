require "admin_app_helper"

RSpec.feature "Admin / Posts / Edit", js: true do
  include_context "admin users"
  include_context "admin posts"

  background do
    sign_in(jane.email, jane.password)
  end

  scenario "I can edit a post" do
    find("nav a", text: "Posts").trigger("click")

    within("#post-#{sample_post.id}") {
      find("a", text: "Edit").trigger("click")
    }

    find("#title").set("A new title")

    find("button", text: "Save changes").trigger("click")

    expect(page).to have_content("Post has been updated")

    find("nav a", text: "Posts").trigger("click")

    expect(page).to have_content("A Sample Post")
  end

  scenario "I can see validation errors" do
    find("nav a", text: "Posts").trigger("click")

    within("#post-#{sample_post.id}") {
      find("a", text: "Edit").trigger("click")
    }

    find("#title").set("")

    find("button", text: "Save changes").trigger("click")

    expect(page).to have_content("must be filled")
  end
end
