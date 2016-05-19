require "admin/persistence/uniqueness_check"
require "admin/persistence/post_color_picker"

Admin::Container.namespace "admin.persistence" do |container|
  container.register "user_email_uniqueness_check" do
    Admin::Persistence::UniquenessCheck.new(
      container["core.persistence.rom"].relation(:users),
      :email
    )
  end

  container.register "post_slug_uniqueness_check" do
    Admin::Persistence::UniquenessCheck.new(
      container["core.persistence.rom"].relation(:posts),
      :slug
    )
  end

  container.register "post_color_picker" do
    Admin::Persistence::PostColorPicker.new(
      Types::Color,
      container["admin.persistence.repositories.posts"].method(:recent_colors)
    )
  end
end
