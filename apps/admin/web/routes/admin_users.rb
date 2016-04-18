module Admin
  class Application < Dry::Web::Application
    route "admin_user" do |r|
      r.post do
        r.resolve "admin.operations.admin_users.update_admin_user" do |update_admin_user|
          update_admin_user.(current_user.id, r[:admin_user]) do |m|
            m.success do
              flash[:notice] = "Your account has been updated."
              r.redirect "/admin"
            end

            m.failure do |errors|
              r.resolve "admin.views.admin_user.edit" do |view|
                view.(scope: current_page, params: r[:admin_user], errors: errors)
              end
            end
          end
        end
      end

      r.is "edit" do
        r.get do
          r.view "admin_user.edit"
        end
      end
    end
  end
end
