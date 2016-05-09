module Main
  module Decorators
    class PublicPost < SimpleDelegator
      def published_date
        published_at.strftime('%d %b %Y')
      end
    end
  end
end
