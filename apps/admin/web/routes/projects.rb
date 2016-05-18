class Admin::Application < Dry::Web::Application
  route "projects" do |r|
    r.authorize do
      r.is do
        r.get do
          r.view "projects.index", page: r[:page]
        end

        r.post do
          r.resolve "admin.projects.operations.create" do |create_project|
            create_project.(r[:project]) do |m|
              m.success do
                flash[:notice] = t["admin.projects.project_created"]
                r.redirect "/admin/projects"
              end

              m.failure do |validation|
                r.view "projects.new", validation: validation
              end
            end
          end
        end
      end

      r.get "new" do
        r.view "projects.new"
      end

      r.on ":slug" do |slug|
        r.get "edit" do
          r.view "projects.edit", slug: slug
        end

        r.post do
          r.resolve "admin.projects.operations.update" do |update_project|
            update_project.(slug, r[:project]) do |m|
              m.success do
                flash[:notice] = t["admin.projects.project_updated"]
                r.redirect "/admin/projects"
              end

              m.failure do |validation|
                r.view "projects.edit", slug: slug, project_validation: validation
              end
            end
          end
        end
      end
    end
  end
end
