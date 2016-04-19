require "berg/email"
require "main/container"

module Main
  class Email < Berg::Email
    configure do |config|
      config.root = Container.root.join("emails")
      config.name = "email"
    end
  end
end
