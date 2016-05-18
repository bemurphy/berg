require "berg/decorator"

module Main
  module Decorators
    class PublicPost < Berg::Decorator
      def published_date
        published_at.strftime('%d %b %Y')
      end
    end
  end
end
