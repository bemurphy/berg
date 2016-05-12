RSpec.shared_context "admin tags" do
  def create_tag(name)
    Admin::Container["admin.tags.operations.create"].({
      name: name
    }).value
  end
end
