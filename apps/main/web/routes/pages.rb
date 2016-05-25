module Main
  class Application < Dry::Web::Application
    route "about" do |r|
      r.view "pages.about"
    end
  end
end
