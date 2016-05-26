require "babosa"

RSpec.shared_context "admin posts" do
  def create_post(title, attrs = {})
    # TODO: we need fixtures
    Admin::Container["admin.posts.operations.create"].({
      "title" => title,
      "teaser" => "A teaser for this sample post",
      "body" => "Some sample content for this post",
      "person_id" => Admin::Container["admin.persistence.repositories.people"].by_email("person@example.com").id,
      "slug" => title.to_slug.normalize.to_s
    }.merge(attrs)).value
  end

  let!(:sample_post) { create_post("A Sample Post") }
end
