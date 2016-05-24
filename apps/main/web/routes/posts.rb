module Main
  class Application < Dry::Web::Application
    route "posts" do |r|
      r.on ":slug" do |slug|
        r.resolve("main.operations.posts.check_publication_state") do |check_publication_state|
          check_publication_state.(slug) do |m|
            m.failure do
              response.status = 404
              r.view "errors.error_404"
            end

            m.success do
              r.view "posts.show", slug: slug
            end
          end
        end
      end

      r.view "posts.index", page: r[:page]
    end
  end
end
