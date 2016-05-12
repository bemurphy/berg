require "admin/import"
require "admin/view"
require "admin/posts/forms/create_form"

module Admin
  module Views
    module Posts
      class New < Admin::View
        include Admin::Import("admin.posts.forms.create_form")

        configure do |config|
          config.template = "posts/new"
        end

        def locals(options = {})
          super.merge(post_form: form_data(options[:validation]))
        end

        def form_data(validation)
          if validation
            create_form.build(validation, validation.messages)
          else
            create_form.build
          end
        end
      end
    end
  end
end
