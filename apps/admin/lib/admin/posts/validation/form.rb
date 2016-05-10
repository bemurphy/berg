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

        optional(:title).filled
        optional(:teaser).filled
        optional(:body).filled
        optional(:slug).filled
        optional(:previous_slug).maybe
        optional(:author_id).filled(:int?)
        optional(:status).filled(inclusion?: Entities::Post::Status.values)
        optional(:published_at).maybe(:time?)
        rule(published_at: [:status, :published_at]) do |status, published_at|
          status.eql?("published").then(published_at.filled?)
        end

        rule(slug: [:slug, :previous_slug]) do |slug, previous_slug|
          slug.not_eql?(previous_slug).then(slug.slug_unique?)
        end
        key(:tag_ids).each(:int?)
      end
    end
  end
end
