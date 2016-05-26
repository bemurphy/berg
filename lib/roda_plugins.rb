require "roda"
require "rack/csrf"

class Roda
  module RodaPlugins
    module Page
      module InstanceMethods
        def current_page
          page.with_flash(flash)
        end

        def page
          self.class["page"].with(
            csrf_metatag: -> { Rack::Csrf.metatag(request.env) },
            csrf_tag: -> { Rack::Csrf.tag(request.env) },
            csrf_token: -> { Rack::Csrf.token(request.env) }
          )
        end
      end
    end

    module View
      module RequestMethods
        def view(name, overrides = {})
          options = {scope: scope.current_page}.merge(overrides)
          is(to: "#{scope.name}.views.#{name}", call_with: [options])
        end
      end
    end

    module Auth
      module RequestMethods
        def authorize
          resolve("admin.authentication.authorize") do |authorize|
            authorize.(scope.session) do |m|
              m.success do |user|
                set_current_user!(user)
              end

              m.failure do |error|
                scope.flash[:alert] = auth_error(error)
                redirect "/admin/sign-in"
              end

              yield
            end
          end
        end

        def auth_error(id)
          scope.class["core.i18n.t"]["admin.auth.#{id}"]
        end

        def current_user
          scope.env["admin.current_user"]
        end

        def set_current_user!(user)
          scope.env["admin.current_user"] = user
        end
      end
    end

    register_plugin :page, Page
    register_plugin :view, View
    register_plugin :auth, Auth
  end
end
