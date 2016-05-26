require "main_app_helper"

RSpec.feature "Main / Posts / Index", js: false do

  include_context 'main posts'
  include_context 'main categories'

  before do
    @user = create_user(first_name: "Jane", last_name: "Doe")
    21.times do |i|
      create_post("foo #{i+1}", "teaser-foo-#{i+1}", "foo-#{i+1}", @user)
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

  scenario "I can filter posts by category" do
    category = create_category("Ruby", "ruby")
    post = create_post("A Ruby Post", "it'll be good", "a-ruby-post", @user)
    categorise_post(category[:id], post[:id])

    visit "/posts/category/ruby"

    expect(page).to have_content "A Ruby Post"
  end

  scenario "I see the 404 page if I try view a category that doesn't exist" do
    visit "/posts/category/rb"

    expect(page).to have_content "Oops! We couldn’t find this page."
  end

end
