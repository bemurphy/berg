require "main_app_helper"

RSpec.feature "Main / Projects / Show", js: false do
  include_context "main_projects"

  before do
    user = create_user(first_name: "Jane", last_name: "Doe")
    5.times do |i|
      create_project("foo #{i + 1}", "teaser-foo-#{i + 1}", "foo-#{i + 1}", user)
    end
  end

  scenario "I can view a project's detail page" do
    visit "/projects"
    click_link "foo 1"

    expect(page.current_path).to eq "/projects/foo-1"
    expect(page).to have_content "test"
  end

  scenario "I see a 404 page when trying to view an un-published project" do
    user = create_user(first_name: "John", last_name: "Doe")
    create_project("Secret project", "teaser", "secret-project", user, "draft")

    visit "/projects/secret-project"

    expect(page.current_path).to eq "/projects/secret-project"
    expect(page).to have_content "Oops! We couldn’t find this page."
  end
end
