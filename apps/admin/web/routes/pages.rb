class Admin::Application < Dry::Web::Application
  route "pages" do |r|
    r.authorize do
      r.on "about" do
        r.is do
          r.get do
            r.view "pages.about.edit"
          end

          r.post do
            r.resolve "admin.pages.about.operations.update" do |update_about_page|
              update_about_page.(r[:page]) do |m|
                m.success do
                  flash[:notice] = t["admin.pages.page_update"]
                  r.redirect "/admin"
                end

                m.failure do |validation|
                  r.view "pages.about.edit", validation: validation
                end
              end
            end
          end
        end
      end
    end
  end
end
