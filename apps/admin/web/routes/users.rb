class Admin::Application < Dry::Web::Application
  route "users" do |r|
    r.on "password-reset" do
      r.get do
        r.view "users.password_reset"
      end

      r.post do
        r.resolve "admin.transactions.password_reset_request" do |password_reset_request|
          password_reset_request.(r[:email]) do |m|
            m.success do
              flash["notice"] = "Check your email for password reset instructions"
              r.redirect "/admin/sign-in"
            end

            m.failure do |error|
              flash.now["notice"] = t["admin.errors.auth.#{error}"]
              r.view "users.password_reset"
            end
          end
        end
      end
    end

    r.on "update-password/:access_token" do |access_token|
      r.resolve "admin.authentication.access_token" do |auth|
        auth.(access_token) do |m|
          m.success do |user|
            r.get do
              r.view "users.update_password", id: user.id
            end

            r.put do
              r.resolve "admin.users.operations.change_password" do |change_password|
                change_password.(user.id, r[:user]) do |t|
                  t.success do
                    session[:user_id] = user.id
                    r.redirect "/admin"
                  end

                  t.failure do |validation|
                    r.view "users.update_password", id: user.id, validation: validation
                  end
                end
              end
            end
          end

          m.failure do |error|
            flash["notice"] = t["admin.errors.auth.#{error}"]
            r.redirect "/admin/sign-in"
          end
        end
      end
    end

    r.authorize do
      r.get "" do
        r.view "users.index", page: r[:page] || 1
      end

      r.get "new" do
        r.view "users.new"
      end

      r.post do
        r.resolve "admin.transactions.create_user" do |create_user|
          create_user.(r[:user]) do |m|
            m.success do
              flash["notice"] = "User has been created"
              r.redirect "/admin/users"
            end

            m.failure do |validation|
              r.view "users.new", validation: validation
            end
          end
        end
      end

      r.on ":id" do |id|
        r.get "edit" do
          r.view "users.edit", id: id
        end

        r.is do
          r.resolve "admin.users.operations.update" do |update_user|
            update_user.(id, r[:user]) do |m|
              m.success do
                flash["notice"] = "User has been updated"
                r.redirect "/admin/users/#{id}/edit"
              end

              m.failure do |validation|
                r.view "users.edit", user_validation: validation
              end
            end
          end
        end

        r.on "password" do
          r.get do
            r.view "users.password", id: id
          end
          r.put do
            r.resolve "admin.users.operations.change_password" do |change_password|
              change_password.(id, r[:user]) do |m|
                m.success do
                  flash["notice"] = "Password has been changed"
                  r.redirect "/admin/users/#{id}/password"
                end

                m.failure do |validation|
                  r.view "users.password", pass_validation: validation
                end
              end
            end
          end
        end
      end
    end
  end
end
