module Admin
  module Decorators
    class Project < SimpleDelegator
      def status_class
        case status
        when "draft"
          "ghost"
        when "deleted"
          "warning"
        when "published"
          "success"
        end
      end

      def status_label
        status.capitalize
      end
    end
  end
end
