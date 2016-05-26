require "berg/decorator"

module Main
  module Decorators
    class PublicPerson < Berg::Decorator
      def job_title_text
        job_title.value
      end

      def avatar_url
        avatar.value
      end

      def twitter_username
        twitter.value
      end

      def website_url
        website.value
      end
    end
  end
end
