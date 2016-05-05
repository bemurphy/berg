require "admin/import"
require "berg/validation/form"

module Admin
  module Posts
    module Validation
      Form = Berg::Validation.Form do
        configure do
          config.messages = :i18n

          option :post_slug_uniqueness_check, Admin::Container["admin.persistence.post_slug_uniqueness_check"]

          def slug_unique?(value)
            post_slug_uniqueness_check.(value)
          end
        end

        optional(:title).filled
        optional(:body).filled
        optional(:slug).filled(:slug_unique?)
        optional(:author_id).filled(:int?)
        optional(:status).filled(inclusion?: Entities::Post::Status.values)
      end
    end
  end
end
