require "admin/import"
require "berg/validation/form"

module Admin
  module Projects
    module Validation
      Form = Berg::Validation.Form do
        configure do
          config.messages = :i18n

          option :project_slug_uniqueness_check, Admin::Container["admin.persistence.project_slug_uniqueness_check"]

          def slug_unique?(value)
            project_slug_uniqueness_check.(value)
          end

          def not_eql?(input, value)
            !input.eql?(value)
          end
        end

        required(:title).filled
        required(:client).filled
        required(:url).filled
        required(:intro).filled
        required(:body).filled
        optional(:slug).filled
        optional(:previous_slug).maybe
        required(:tags).filled
        optional(:status).filled(inclusion?: Entities::Project::Status.values)
        optional(:published_at).maybe(:time?)
        rule(published_at: [:status, :published_at]) do |status, published_at|
          status.eql?("published").then(published_at.filled?)
        end

        rule(slug: [:slug, :previous_slug]) do |slug, previous_slug|
          slug.not_eql?(previous_slug).then(slug.slug_unique?)
        end
      end
    end
  end
end
