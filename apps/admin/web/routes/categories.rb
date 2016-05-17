class Admin::Application < Dry::Web::Application
  route "categories" do |r|
    r.authorize do
      r.is do
        r.get do
          r.view "categories.index", page: r[:page] || 1
        end

        r.post do
          r.resolve "admin.categories.operations.create" do |create_category|
            create_category.(r[:category]) do |m|
              m.success do
                flash[:notice] = t["admin.categories.category_created"]
                r.redirect "/admin/categories"
              end

              m.failure do |validation|
                r.view "categories.new", validation: validation
              end
            end
          end
        end
      end

      r.get "new" do
        r.view "categories.new"
      end

      r.on ":slug" do |slug|
        r.get "edit" do
          r.view "categories.edit", slug: slug
        end

        r.post do
          if r["_method"] == "delete"
            r.resolve("admin.categories.operations.delete") do |delete_category|
              delete_category.(slug)
              flash[:notice] = t["admin.categories.category_deleted"]
              r.redirect '/admin/categories'
            end
          else
            r.resolve "admin.categories.operations.update" do |update_category|
              update_category.(slug, r[:category]) do |m|
                m.success do
                  flash[:notice] = t["admin.categories.category_updated"]
                  r.redirect "/admin/categories"
                end

                m.failure do |validation|
                  r.view "categories.edit", slug: slug, category_validation: validation
                end
              end
            end
          end
        end
      end
    end
  end
end
