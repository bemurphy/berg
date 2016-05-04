require "berg/validation/form"

module Admin
  module Posts
    module Validation
      Form = Berg::Validation.Form do
        optional(:title).filled
        optional(:body).filled
        optional(:slug).filled
      end
    end
  end
end
