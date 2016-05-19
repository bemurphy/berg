module Admin
  module Persistence
    class PostColorPicker
      attr_reader :colors, :recently_used_color_finder

      def initialize(colors, recently_used_color_finder)
        @colors = colors
        @recently_used_color_finder = recently_used_color_finder
      end

      def call
        recent_colors = recently_used_color_finder.().uniq
        (colors.values - recent_colors).sample(1).first
      end
    end
  end
end
