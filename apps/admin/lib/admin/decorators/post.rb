module Admin
  module Decorators
    class Post < SimpleDelegator
      def published_date
        published_at.strftime("%e %b %Y %H:%M:%S%p")
      end
    end
  end
end
