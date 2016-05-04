RSpec.shared_context "admin posts" do
  def create_post(title, attrs = {})
    # TODO: we need fixtures
    Admin::Container["admin.posts.operations.create"].({
      "title" => title,
      "body" => "Some sample content for this post",
      "slug" => "a-sample-post",
      "author_id" => Admin::Container["admin.persistence.repositories.users"].by_email("jane@doe.org").id
    }.merge(attrs)).value
  end

  let!(:sample_post) { create_post("A Sample Post") }
end
