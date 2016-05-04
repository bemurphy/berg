require "berg/validation/form"

module Admin
  module Posts
    module Validation
      Form = Berg::Validation.Form do
        optional(:title).filled
        optional(:body).filled
        optional(:author_id).filled(:int?)
        optional(:status).filled(inclusion?: Entities::Post::Status.values)
      end
    end
  end
end
