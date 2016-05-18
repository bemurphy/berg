module Main
  module Decorators
    class PublicPost < SimpleDelegator
      def published_date
        published_at.strftime('%d %b %Y') if published_at
      end
    end
  end
end
