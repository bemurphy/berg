require "main_app_helper"

RSpec.feature "Main / Posts / Show", js: false do

  include_context 'main people'
  include_context 'main posts'

  before do
    author = create_person("Jane", "Doe", "person@example.com", "bio")
    5.times do |i|
      create_post("foo #{i+1}", "teaser-foo-#{i+1}", "foo-#{i+1}", author)
    end
  end

  scenario "I can view a post's detail page" do
    visit "/posts"
    click_link "foo 1"

    expect(page.current_path).to eq "/posts/foo-1"
    expect(page).to have_content "test"
  end

  scenario "I see a 404 page when trying to view an un-published post" do
    author = create_person("Jane", "Doe", "person@example.com", "bio")
    create_post("Secret post", "teaser", "secret-post", author, "draft")

    visit "/posts/secret-post"

    expect(page.current_path).to eq "/posts/secret-post"
    expect(page).to have_content "Oops! We couldn’t find this page."
  end
end
