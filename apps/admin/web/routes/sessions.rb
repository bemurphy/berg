class Admin::Application < Dry::Web::Application
  route "sign-in"  do |r|
    r.get do
      r.view "sign_in"
    end

    r.post do
      r.resolve "admin.authentication.authenticate" do |authenticate|
        authenticate.(r[:user]) do |m|
          m.success do |user|
            flash["notice"] = "You are now signed in"
            session[:user_id] = user.id
            r.redirect "/admin"
          end

          m.failure do |error|
            flash["notice"] = t["errors.#{error}"]
            r.redirect "/admin/sign-in"
          end
        end
      end
    end
  end

  route "sign-out" do |r|
    flash["notice"] = "You are now signed out"
    session[:user_id] = env["admin.current_user"] = nil
    r.redirect "/admin/sign-in"
  end
end
