require "slim"
require "dry-view"

require "admin/container"
require "admin/page"

require "berg/assets"

module Admin
  Container.register "page", Page.new(assets: Berg::Assets.new)

  class View < Dry::View::Layout
    setting :root, Container.root.join("web/templates")
    setting :scope, Container["page"]
    setting :formats, { html: :slim }
    setting :name, "admin"

    def locals(options)
      super.merge(options[:scope].view_locals)
    end
  end
end
