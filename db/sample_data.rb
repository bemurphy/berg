require_relative "../core/boot"
require "faker"

def core
  Berg::Container
end

def main
  Main::Container
end

def admin
  Admin::Container
end

def create_user(attrs)
  if !admin["admin.persistence.repositories.users"].by_email(attrs[:email])
    admin["admin.users.operations.create"].call(attrs).value
  end
end

def create_post(attrs)
  if !admin["admin.persistence.repositories.posts"].by_slug(attrs[:slug])
    admin["admin.posts.operations.create"].call(attrs).value
  end
end

def create_project(attrs)
  if !admin["admin.persistence.repositories.projects"].by_slug(attrs[:slug])
    admin["admin.projects.operations.create"].call(attrs).value
  end
end

def create_category(attrs)
  if !admin["admin.persistence.repositories.categories"].by_slug(attrs[:slug])
    admin["admin.categories.operations.create"].call(attrs).value
  end
end

create_user(
  email: "hello@icelab.com.au",
  first_name: "Icelab",
  last_name: "Admin",
  active: true
)

author = admin["admin.persistence.repositories.users"].by_email("hello@icelab.com.au")

20.times do |n|
  create_post(
    title: Faker::Hipster.sentence,
    teaser: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph,
    status: "draft",
    author_id: author.id
  )
end

20.times do |n|
  create_project(
    title: Faker::Hipster.sentence,
    client: Faker::Company.name,
    url: Faker::Internet.url,
    intro: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph,
    tags: Faker::Hipster.word,
    status: "draft"
  )
end

{ ruby: "Ruby",
  dry_web: "dry-web",
  rails: "Rails",
  javascript: "Javascript",
  ios: "iOS",
  design: "Design",
  react: "React" }.each do |slug, name|
    create_category(name: name, slug: slug)
end
