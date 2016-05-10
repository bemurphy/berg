require "babosa"

module Admin
  module Posts
    class Slugify
      def call(input, checker)
        input_slug = input.strip.to_slug.to_ascii.normalize.to_s
        slug = input_slug
        i = 1
        # Adds an incremental number to the end of the slug if it already exists.
        while checker.call(slug)
          slug = input_slug + i.to_s
          i += 1
        end
        slug
      end
    end
  end
end
