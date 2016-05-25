require "admin/import"
require "admin/paginator"
require "admin/view"

module Admin
  module Views
    module People
      class Index < Admin::View
        include Admin::Import("admin.persistence.repositories.people")

        configure do |config|
          config.template = "people/index"
        end

        def locals(options = {})
          page      = options[:page] || 1
          per_page  = options[:per_page] || 20

          all_people = people.listing(page: page, per_page: per_page)
          admin_people = all_people.to_a.map { |a| Decorators::Post.new(a) }

          super.merge(
            people: admin_people,
            paginator: Paginator.new(all_people.pager, url_template: "/admin/people?page=%")
          )
        end
      end
    end
  end
end
