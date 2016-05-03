require "bugsnag"
require "rack/csrf"
require "dry/web/application"
require "admin/container"
require "roda_plugins"

module Admin
  class Application < Dry::Web::Application
    configure do |config|
      config.routes = "web/routes".freeze
      config.container = Container
    end

    opts[:root] = Pathname(__FILE__).join("../..").realpath.dirname

    use Rack::Session::Cookie,
      key: "berg.session",
      secret: Berg::Container["config"].session_secret

    use Rack::Csrf, raise: true
    use Bugsnag::Rack

    if Berg::Container["config"].basic_auth_user && Berg::Container["config"].basic_auth_password
      use Rack::Auth::Basic do |username, password|
        username == Berg::Container["config"].basic_auth_user && password == Berg::Container["config"].basic_auth_password
      end
    end

    plugin :error_handler
    plugin :flash
    plugin :view
    plugin :page
    plugin :auth

    def name
      :admin
    end

    def current_user
      env["admin.current_user"]
    end

    def current_page
      current_user ? super.authorized(current_user) : super
    end

    def t
      self.class["core.i18n.t"]
    end

    route do |r|
      r.multi_route

      r.on "forgot-password" do
        r.get do
          r.view "forgot_password"
        end

        r.post do
          r.resolve "admin.transactions.request_password_reset" do |request_password_reset|
            request_password_reset.(r[:email]) do |m|
              m.success do
                flash[:notice] = t["admin.auth.reset_password"]
                r.redirect "/admin/sign-in"
              end

              m.failure do |error|
                flash.now[:notice] = t["admin.auth.#{error}"]
                r.view "forgot_password"
              end
            end
          end
        end
      end

      r.on "reset-password/:access_token" do |access_token|
        r.resolve "admin.authentication.access_token" do |authenticate_access_token|
          authenticate_access_token.(access_token) do |m|
            m.success do |user|
              r.get do
                r.view "reset_password", id: user.id
              end

              r.post do
                r.resolve "admin.users.operations.change_password" do |change_password|
                  change_password.(user.id, r[:user]) do |m|
                    m.success do
                      flash[:notice] = t["admin.auth.password_set"]
                      session[:user_id] = user.id
                      r.redirect "/admin"
                    end

                    m.failure do |validation|
                      r.view "reset_password", id: user.id, pass_validation: validation
                    end
                  end
                end
              end
            end

            m.failure do |error|
              flash[:notice] = t["admin.auth.#{error}"]
              r.redirect "/admin/sign-in"
            end
          end
        end
      end

      r.is do
        r.authorize do
          r.view("home")
        end
      end
    end

    load_routes!

    error do |e|
      if ENV["RACK_ENV"] == "production"
        if e.is_a?(ROM::TupleCountMismatchError)
          response.status = 404
          self.class["main.views.errors.error_404"].(scope: current_page)
        else
          Bugsnag.auto_notify e
          self.class["main.views.errors.error_500"].(scope: current_page)
        end
      else
        Bugsnag.auto_notify e
        raise e
      end
    end
  end
end
