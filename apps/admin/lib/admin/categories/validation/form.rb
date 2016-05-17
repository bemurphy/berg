require "admin/container"
require "berg/validation/form"

module Admin
  module Categories
    module Validation
      Form = Berg::Validation.Form do
        configure do
          config.messages = :i18n

          option :category_slug_uniqueness_check, Admin::Container["admin.persistence.category_slug_uniqueness_check"]

          def slug_unique?(value)
            category_slug_uniqueness_check.(value)
          end

          def not_eql?(input, value)
            !input.eql?(value)
          end
        end

        required(:name).filled
        optional(:slug).maybe
        optional(:previous_slug).maybe

        rule(slug: [:slug, :previous_slug]) do |slug, previous_slug|
          slug.not_eql?(previous_slug).then(slug.slug_unique?)
        end
      end
    end
  end
end
