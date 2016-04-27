require "berg/validation/form"

module Admin
  module Posts
    module Validation
      Form = Berg::Validation.Form do
        optional(:title).required
        optional(:content).required
        optional(:slug).required
      end
    end
  end
end
