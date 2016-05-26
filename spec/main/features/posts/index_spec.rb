require "main_app_helper"

RSpec.feature "Main / Posts / Index", js: false do
  include_context 'main people'
  include_context 'main posts'

  before do
    author = create_person("Jane", "Doe", "person@example.com", "bio")
    21.times do |i|
      create_post("foo #{i+1}", "teaser-foo-#{i+1}", "foo-#{i+1}", author)
    end
  end

  scenario "I can view a list of posts" do
    visit "/posts"

    expect(page).to have_content("foo 1")
  end

  scenario "I can paginate through the list of posts" do
    visit "/posts"

    expect(page).to have_content("Older")
    expect(page).to have_content("Newer")
    expect(page).to_not have_content("foo 21")

    click_link("Older", :match => :first)

    expect(page).to have_content("foo 21")

  end
end
