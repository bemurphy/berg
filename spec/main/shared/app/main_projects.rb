require "babosa"

RSpec.shared_context "main_projects" do

  def create_user(first_name: "Jane", last_name: "Doe")
    Berg::Container["persistence.commands.create_user"].({
      first_name: first_name,
      last_name: last_name,
      email: "#{first_name}#{Random.new.rand(100)}@#{last_name}.org",
      active: true,
      access_token: "123456",
      access_token_expiration: Time.now
    })
  end

  def create_project(title, client, url, status="published")
    Berg::Container["persistence.commands.create_project"].({
      title: title,
      client: client,
      url: url,
      intro: "the intro",
      body: "the body",
      tags: "tag",
      slug: title.to_slug.normalize.to_s,
      status: status,
      published_at: Time.now
    })
  end
end
