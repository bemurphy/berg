require "admin_app_helper"

RSpec.feature "Admin / Posts / Create", js: true do
  include_context "admin users"

  background do
    sign_in(jane.email, jane.password)
  end

  # Currently Formalist appears to not add an ID to selection_field field types so we can't
  # target #author_id - it doesn't exist
  pending "I can create a post, with a slug generated automatically" do
    find("nav a", text: "Posts").trigger("click")

    find("a", text: "Add a post").trigger("click")

    find("#title").set("A sample title")
    find("#teaser").set("A teaser for this sample article")
    find("#body").set("Some sample content for this post")
    find("#author_id").select("Jane")

    find("button", text: "Create post").trigger("click")

    expect(page).to have_content("Post has been created")

    expect(page).to have_content("A sample title")

    expect(page).to have_content("a-sample-title")
  end

  scenario "I can see validation errors" do
    find("nav a", text: "Posts").trigger("click")

    find("a", text: "Add a post").trigger("click")

    find("#title").set("")
    find("#teaser").set("A teaser for this sample article")
    find("#body").set("Some sample content for this post")

    find("button", text: "Create post").trigger("click")

    expect(page).to have_content("must be filled")
  end
end
