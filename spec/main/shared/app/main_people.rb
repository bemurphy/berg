RSpec.shared_context "main people" do
  def create_person(first_name, last_name, email, bio)
    Berg::Container["persistence.commands.create_person"].({
      first_name: first_name,
      last_name: last_name,
      email: email,
      bio: bio,
      short_bio: bio,
      active: true
    })
  end

  # let!(:sample_person) { create_person("Jane", "Doe", "person@example.com", "bio") }
end
