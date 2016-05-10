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
        end

        optional(:title).filled
        optional(:client).filled
        optional(:url).filled
        optional(:intro).filled
        optional(:body).filled
        optional(:slug).filled(:slug_unique?)
        optional(:tags).filled
        optional(:status).filled(inclusion?: Entities::Project::Status.values)
        optional(:published_at).maybe(:time?)
        rule(published_at: [:status, :published_at]) do |status, published_at|
          status.eql?("published").then(published_at.filled?)
        end
      end
    end
  end
end
