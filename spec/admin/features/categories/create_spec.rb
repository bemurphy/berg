require "admin_app_helper"

RSpec.feature "Admin / Categories / Create", js: true do
  include_context "admin users"

  background do
    sign_in(jane.email, jane.password)
  end

  scenario "I can create a category" do
    visit "/admin/categories"

    click_link "Add a category"

    fill_in "name", with: "Ruby"
    fill_in "slug", with: "ruby"

    click_button "Create category"

    expect(page).to have_content("Category has been created")

    expect(page).to have_content("Ruby")
  end

  scenario "I can create a category without a slug and have it set automatically" do
    visit "/admin/categories"

    click_link "Add a category"

    fill_in "name", with: "Ruby on Rails"

    click_button "Create category"

    expect(page).to have_content("Category has been created")

    expect(page).to have_content("Ruby on Rails")
    expect(page).to have_content("ruby-on-rails")
  end
end
