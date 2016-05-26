require "berg/decorator"
require "redcarpet"

module Main
  module Decorators
    class PublicPost < Berg::Decorator
      def published_date
        published_at.strftime('%d %b %Y')
      end

      def body_html
        to_html(body)
      end

      private

      def to_html(input)
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, footnotes: true, hard_wrap: true)
        markdown.render(input)
      end
    end
  end
end
