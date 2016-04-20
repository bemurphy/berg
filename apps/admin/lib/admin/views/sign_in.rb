require "admin/view"

module Admin
  module Views
    class SignIn < Admin::View
      configure do |config|
        config.name = "application"
        config.template = "sign_in"
      end
    end
  end
end
