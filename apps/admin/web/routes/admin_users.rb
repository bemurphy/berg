module Admin
  class Application < Dry::Web::Application
    route "user" do |r|
      r.post do
        r.resolve "admin.operations.users.update_user" do |update_user|
          update_user.(current_user.id, r[:user]) do |m|
            m.success do
              flash[:notice] = "Your account has been updated."
              r.redirect "/admin"
            end

            m.failure do |errors|
              r.resolve "admin.views.user.edit" do |view|
                view.(scope: current_page, params: r[:user], errors: errors)
              end
            end
          end
        end
      end

      r.is "edit" do
        r.get do
          r.view "user.edit"
        end
      end
    end
  end
end
