class Admin::Application < Dry::Web::Application
  route "projects/home_page" do |r|
    r.authorize do
      r.is do
        r.get do
          r.view "projects.home_page.index", page: r[:page]
        end

        r.post do
          r.resolve "admin.projects.home_page.operations.create" do |create_home_page_featured_project|
            create_home_page_featured_project.(r[:home_page_featured_project]) do |m|
              m.success do
                flash[:notice] = t["admin.projects.home_page.project_created"]
                r.redirect "/admin/projects/home_page"
              end

              m.failure do |validation|
                r.view "projects.home_page.new", validation: validation
              end
            end
          end
        end
      end

      r.get "new" do
        r.view "projects.home_page.new"
      end

      r.on ":id" do |slug|
        r.get "edit" do
          r.view "projects.home_page.edit", id: id
        end

        r.post do
          r.resolve "admin.projects.home_page.operations.update" do |update_home_page_featured_project|
            update_home_page_featured_project.(id, r[:home_page_featured_project]) do |m|
              m.success do
                flash[:notice] = t["admin.projects.home_page.project_updated"]
                r.redirect "/admin/projects/home_page"
              end

              m.failure do |validation|
                r.view "projects.home_page.edit", id: id, validation: validation
              end
            end
          end
        end
      end
    end
  end
end
