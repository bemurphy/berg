class Admin::Application < Dry::Web::Application
  route "posts" do |r|
    r.authorize do
      r.is do
        r.get do
          r.view "posts.index", page: r[:page]
        end

        r.post do
          r.resolve "admin.posts.operations.create" do |create_post|
            create_post.(r[:post]) do |m|
              m.success do
                flash[:notice] = t["admin.posts.post_created"]
                r.redirect "/admin/posts"
              end

              m.failure do |validation|
                r.view "posts.new", validation: validation
              end
            end
          end
        end
      end

      r.get "new" do
        r.view "posts.new"
      end

      r.on ":slug" do |slug|
        r.get "edit" do
          r.view "posts.edit", slug: slug
        end

        r.post do
          r.resolve "admin.posts.operations.update" do |update_post|
            update_post.(slug, r[:post]) do |m|
              m.success do
                flash[:notice] = t["admin.posts.post_updated"]
                r.redirect "/admin/posts"
              end

              m.failure do |validation|
                r.view "posts.edit", slug: slug, post_validation: validation
              end
            end
          end
        end
      end
    end
  end
end
