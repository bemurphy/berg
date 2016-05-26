RSpec.shared_context "admin people" do
  def create_person(first_name, last_name, email, bio, attrs = {})
    Admin::Container["admin.people.operations.create"].({
      "first_name" => first_name,
      "last_name" => last_name,
      "email" => email,
      "bio" => bio,
      "short_bio" => bio,
      "active" => true
    }.merge(attrs)).value
  end
end
