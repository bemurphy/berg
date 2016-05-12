module Main
  class Application < Dry::Web::Application
    route "posts" do |r|
      r.view "posts.index", page: r[:page] || 1
    end
  end
end
