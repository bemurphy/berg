require "main_app_helper"

RSpec.feature "Main / Projects / Index", js: false do
  include_context "main_projects"

  before do
    user = create_user(first_name: "Jane", last_name: "Doe")
    21.times do |i|
      create_project("Foo #{i + 1}", "Foo Corp #{i + 1}", "http://foo-#{i + 1}.com")
    end
  end

  scenario "I can view a list of projects" do
    visit "/projects"

    expect(page).to have_content("Foo 1")
  end

  scenario "I can paginate through the list of projects" do
    visit "/projects"

    expect(page).to have_content("Older")
    expect(page).to have_content("Newer")
    expect(page).to_not have_content("Foo 21")

    click_link("Older", :match => :first)

    expect(page).to have_content("Foo 21")
  end
end
