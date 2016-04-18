require "admin/view"

module Admin
  module Views
    class Home < Admin::View
      configure do |config|
        config.template = "home"
      end
    end
  end
end
