require "admin/view"

module Admin
  module Views
    module Errors
      class Error404 < Admin::View
        configure do |config|
          config.template = "errors/404"
        end
      end
    end
  end
end
