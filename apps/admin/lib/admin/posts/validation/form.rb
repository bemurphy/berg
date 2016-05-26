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

          def not_eql?(input, value)
            !input.eql?(value)
          end
        end

        # Required in both the new and edit forms
        required(:title).filled
        required(:teaser).filled
        required(:body).filled
        required(:person_id).filled(:int?)

        # Required in only the edit form
        optional(:slug).filled
        optional(:previous_slug).maybe
        optional(:person_id).filled(:int?)
        optional(:post_categories).each(:int?)
        optional(:status).filled(included_in?: Entities::Post::Status.values)
        optional(:published_at).maybe(:time?)

        rule(slug: [:slug, :previous_slug]) do |slug, previous_slug|
          slug.not_eql?(previous_slug).then(slug.slug_unique?)
        end

        rule(published_at: [:status, :published_at]) do |status, published_at|
          status.eql?("published").then(published_at.filled?)
        end
      end
    end
  end
end
