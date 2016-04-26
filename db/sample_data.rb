require_relative "../core/boot"

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

# Default password is changeme
create_user(
  email: "hello@icelab.com.au",
  name: "Icelab Admin"
)
