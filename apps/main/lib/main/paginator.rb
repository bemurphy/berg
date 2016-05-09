require "forwardable"

module Main
  class Paginator
    class Entry
      attr_reader :number

      def initialize(number, current:)
        @number = number
        @current = current
      end

      def to_s
        number.to_s
      end

      def current?
        !!@current
      end
    end

    extend Forwardable

    def_delegators :@pager,
      :current_page,
      :per_page,
      :next_page,
      :prev_page,
      :total,
      :total_pages

    # @api private
    attr_reader :url_template
    attr_reader :buffer

    def initialize(pager, url_template:, buffer: 2)
      @pager = pager
      @url_template = url_template
      @buffer = buffer
    end

    def first_page
      1
    end

    def first_page?
      current_page == first_page
    end

    def last_page
      total_pages
    end

    def last_page?
      current_page == last_page
    end

    def prev_gap?
      current_page - buffer > first_page
    end

    def next_gap?
      current_page + buffer < last_page
    end

    def single_page?
      total_pages <= 1
    end

    def each_entry
      return to_enum(:each_entry) unless block_given?

      entry_numbers.each do |number|
        yield Entry.new(number, current: number == current_page)
      end
    end

    def url_for_page(page)
      url_template.sub("%", page.to_s)
    end

    private

    def entry_numbers
      left_edge = current_page - buffer
      left_edge = 1 if left_edge < 1

      right_edge = current_page + buffer
      right_edge = total_pages if right_edge > total_pages

      left_edge.upto(right_edge).to_a
    end
  end
end
