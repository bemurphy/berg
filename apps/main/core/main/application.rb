require "bugsnag"
require "rack/csrf"
require "dry/web/application"
require_relative "container"
require "roda_plugins"

module Main
  class Application < Dry::Web::Application
    configure do |config|
      config.routes = "web/routes".freeze
      config.container = Container
    end

    opts[:root] = Pathname(__FILE__).join("../..").realpath.dirname

    use Rack::Session::Cookie, key: "berg.session", secret: Berg::Container["config"].session_secret
    use Rack::Csrf, raise: true
    use Bugsnag::Rack

    plugin :error_handler
    plugin :flash

    plugin :view
    plugin :page

    def name
      :main
    end

    route do |r|
      r.root do
        r.view "home"
      end

      r.multi_route
    end

    error do |e|
      Bugsnag.auto_notify e

      if ENV["RACK_ENV"] == "production"
        if e.is_a?(ROM::TupleCountMismatchError)
          response.status = 404
          self.class["main.views.errors.error_404"].(scope: current_page)
        else
          self.class["main.views.errors.error_500"].(scope: current_page)
        end
      else
        raise e
      end
    end

    load_routes!
  end
end
