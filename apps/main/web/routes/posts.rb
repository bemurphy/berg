module Main
  class Application < Dry::Web::Application
    route "posts" do |r|
      r.on ":slug" do |slug|
        r.get "show" do
          r.view "posts.show", slug: slug
        end
      end

      r.view "posts.index", page: r[:page] || 1
    end
  end
end
