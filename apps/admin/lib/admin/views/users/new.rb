require "admin/view"

module Admin
  module Views
    module User
      class New < Admin::View
        configure do |config|
          config.template = "user/new"
        end
      end
    end
  end
end
