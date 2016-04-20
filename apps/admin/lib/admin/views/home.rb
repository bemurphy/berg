require "admin/view"

module Admin
  module Views
    class Home < Admin::View
      configure do |config|
        config.template = "home"
      end

      def locals(options = {})
        super.merge(
          current_user: options[:scope].current_user
        )
      end
    end
  end
end
