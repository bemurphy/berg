class Admin::Application < Dry::Web::Application
  route("users") do |r|

    r.authorize do
      r.get("") do
        r.view("users.index", page: r[:page] || 1)
      end

      r.get("new") do
        r.view("users.new")
      end

      r.post do
        r.resolve("admin.transactions.create_user") do |create_user|
          create_user.(r[:user]) do |m|
            m.success do
              flash["notice"] = "User has been created"
              r.redirect "/admin/users"
            end

            m.failure do |validation|
              r.view("users.new", validation: validation)
            end
          end
        end
      end

      r.on(":id") do |id|
        r.get("edit") do
          r.view("users.edit", id: id)
        end

        r.is do
          r.resolve("admin.users.operations.update") do |update_user|
            update_user.(id, r[:user]) do |m|
              m.success do
                flash["notice"] = "User has been updated"
                r.redirect "/admin/users/#{id}/edit"
              end

              m.failure do |validation|
                r.view("users.edit", user_validation: validation)
              end
            end
          end
        end

        r.on("password") do
          r.get do
            r.view("users.password", id: id)
          end
          r.put do
            r.resolve("admin.users.operations.change_password") do |change_password|
              change_password.(id, r[:user]) do |m|
                m.success do
                  flash["notice"] = "Password has been changed"
                  r.redirect "/admin/users/#{id}/password"
                end

                m.failure do |validation|
                  r.view("users.password", pass_validation: validation)
                end
              end
            end
          end
        end
      end
    end
  end
end
