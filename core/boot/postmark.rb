require "postmark"

Berg::Container.boot! :config
Berg::Container.register "postmark", Postmark::ApiClient.new(Berg::Container["config"].postmark_api_key)
