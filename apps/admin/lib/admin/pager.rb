module Admin
  class Pager
    attr_reader :total,
                :per_page,
                :current_page

    def initialize(total:, per_page:, current_page:)
      @total        = total
      @per_page     = per_page
      @current_page = current_page
    end

    def total_pages
      pages = total.to_f / per_page
      if pages % 1 == 0
        pages
      else
        pages + 1
      end.to_i
    end

    def next_page
      if current_page < total_pages
        current_page + 1
      end
    end

    def prev_page
      if current_page > 1
        current_page - 1
      end
    end
  end
end
