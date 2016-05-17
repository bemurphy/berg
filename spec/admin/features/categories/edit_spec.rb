require "admin_app_helper"

RSpec.feature "Admin / Categories / Edit", js: true do
  include_context "admin users"
  include_context "admin categories"

  background do
    sign_in(jane.email, jane.password)
    create_category("Ruby")
  end

  scenario "I can edit a category" do
    visit "/admin/categories"

    within("#category-ruby") {
      click_link "Ruby"
    }

    fill_in :name, with: "PHP"

    click_button "Save changes"

    expect(page).to have_content("Category has been updated")
    expect(page).to have_content("PHP")
  end

  scenario "I can edit a category and change its slug" do
    visit "/admin/categories"

    within("#category-ruby") {
      click_link "Ruby"
    }

    fill_in :name, with: "PHP"
    fill_in :slug, with: "php-hypertext-preprocessor"

    click_button "Save changes"

    expect(page).to have_content("Category has been updated")
    expect(page).to have_content("PHP")
    expect(page).to have_content("php-hypertext-preprocessor")
  end

  scenario "I can see validation errors" do
    visit "/admin/categories"

    within("#category-ruby") {
      click_link "Ruby"
    }

    fill_in :name, with: ""

    click_button "Save changes"

    expect(page).to have_content("must be filled")
  end
end
