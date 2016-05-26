require "admin_app_helper"

RSpec.feature "Admin / Posts / Create", js: true do
  include_context "admin people"
  include_context "admin users"
  include_context "admin categories"

  background do
    sign_in(jane.email, jane.password)
    create_category("My Tag")
  end

  # Currently Formalist appears to not add an ID to selection_field field types so we can't
  # target #person_id - it doesn't exist
  scenario "I can create a post, with a slug generated automatically" do
    find("nav a", text: "Posts").trigger("click")

    find("a", text: "Add a post").trigger("click")

    find("#title").set("A sample title")
    find("#teaser").set("A teaser for this sample article")
    find("#body").set("Some sample content for this post")

    find(:xpath, "//button[contains(@class, 'selection-field')]", match: :first).trigger("click")
    find(:xpath, "//button[contains(@class, 'selection-field__optionButton')][div='#{jane.first_name} #{jane.last_name}']").trigger("click")

    find("button", text: "Create post").trigger("click")

    expect(page).to have_content("Post has been created")

    expect(page).to have_content("A sample title")
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

  scenario "I can add an existing category to a post" do
    find("nav a", text: "Posts").trigger("click")

    find("a", text: "Add a post").trigger("click")

    find("#title").set("A sample title")
    find("#teaser").set("A teaser for this sample article")
    find("#body").set("Some sample content for this post")
    find("input[name='post[person_id]']", visible: false).set(jane.id)

    find(:xpath, "//button[contains(@class, 'selection-field')]", match: :first).trigger("click")
    find(:xpath, "//button[contains(@class, 'selection-field__optionButton')][div='#{jane.first_name} #{jane.last_name}']").trigger("click")

    find(:xpath, "//button[contains(@class, 'multi-selection-field')]").trigger("click")
    find(:xpath, "//button[contains(@class, 'multi-selection-field__optionButton')][div='My Tag']").trigger("click")

    find("button", text: "Create post").trigger("click")

    expect(page).to have_content("Post has been created")

    find("a", text: "A sample title").trigger("click")

    expect(page).to have_content("My Tag")
  end
end
