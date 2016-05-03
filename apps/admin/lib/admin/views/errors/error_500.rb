require "admin/view"

module Admin
  module Views
    module Errors
      class Error500 < Admin::View
        configure do |config|
          config.template = "errors/500"
        end
      end
    end
  end
end
