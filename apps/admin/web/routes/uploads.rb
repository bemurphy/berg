class Admin::Application < Dry::Web::Application
  route "uploads" do |r|
    r.on "presign" do
      r.post do
        r.resolve "admin.uploads.operations.presign" do |presign|
          presign.() do |m|
            m.success do |payload|
              payload
            end
          end
        end
      end
    end
  end
end
