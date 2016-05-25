require "admin/persistence/uniqueness_check"

Admin::Container.namespace "admin.persistence" do |container|
  container.register "user_email_uniqueness_check" do
    Admin::Persistence::UniquenessCheck.new(
      container["core.persistence.rom"].relation(:users),
      :email
    )
  end

  container.register "person_email_uniqueness_check" do
    Admin::Persistence::UniquenessCheck.new(
      container["core.persistence.rom"].relation(:people),
      :email
    )
  end

  container.register "post_slug_uniqueness_check" do
    Admin::Persistence::UniquenessCheck.new(
      container["core.persistence.rom"].relation(:posts),
      :slug
    )
  end

  container.register "project_slug_uniqueness_check" do
    Admin::Persistence::UniquenessCheck.new(
      container["core.persistence.rom"].relation(:projects),
      :slug
    )
  end
end
