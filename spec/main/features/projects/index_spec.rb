require "main_app_helper"

RSpec.feature "Main / Projects / Index", js: false do
  include_context "main_projects"

  before do
    21.times do |i|
      create_project("Foo#{i + 1}Corp")
    end
  end

  scenario "I can view a list of projects" do
    visit "/projects"

    expect(page).to have_content("Foo21Corp")
  end

  scenario "I can paginate through the list of projects" do
    visit "/projects"

    expect(page).to have_content("Older")
    expect(page).to have_content("Newer")

    # Projects are sorted by published_at descending, so we shouldn't see the first post (Foo1Corp)
    # on the first page
    expect(page).to_not have_content("Foo1Corp")

    click_link("Older", :match => :first)

    expect(page).to have_content("Foo1Corp")
  end
end
