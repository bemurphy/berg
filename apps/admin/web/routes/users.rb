class Admin::Application < Dry::Web::Application
  route "users" do |r|
    r.on "password-reset" do
      r.get do
        r.view "users.password_reset"
      end

      r.post do
        r.resolve "admin.transactions.request_password_reset" do |request_password_reset|
          request_password_reset.(r[:email]) do |m|
            m.success do
              flash["notice"] = t["admin.auth.password_reset"]
              r.redirect "/admin/sign-in"
            end

            m.failure do |error|
              flash.now["notice"] = t["admin.auth.#{error}"]
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

            r.post do
              r.resolve "admin.users.operations.change_password" do |change_password|
                change_password.(user.id, r[:user]) do |m|
                  m.success do
                    flash["notice"] = t["admin.auth.password_set"]
                    session[:user_id] = user.id
                    r.redirect "/admin"
                  end

                  m.failure do |validation|
                    r.view "users.update_password", id: user.id, pass_validation: validation
                  end
                end
              end
            end
          end

          m.failure do |error|
            flash["notice"] = t["admin.auth.#{error}"]
            r.redirect "/admin/sign-in"
          end
        end
      end
    end

    r.authorize do
      r.is do
        r.get do
          r.view "users.index", page: r[:page] || 1
        end

        r.post do
          r.resolve "admin.transactions.create_user" do |create_user|
            create_user.(r[:user]) do |m|
              m.success do
                flash["notice"] = t["admin.users.user_created"]
                r.redirect "/admin/users"
              end

              m.failure do |validation|
                r.view "users.new", validation: validation
              end
            end
          end
        end
      end

      r.get "new" do
        r.view "users.new"
      end

      r.on ":id" do |id|
        r.get "edit" do
          r.view "users.edit", id: id
        end

        r.is do
          r.resolve "admin.users.operations.update" do |update_user|
            update_user.(id, r[:user]) do |m|
              m.success do
                flash["notice"] = t["admin.users.user_updated"]
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
          r.post do
            r.resolve "admin.users.operations.change_password" do |change_password|
              change_password.(id, r[:user]) do |m|
                m.success do
                  flash["notice"] = t["admin.users.password_changed"]
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
