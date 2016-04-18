require "postmark"

IcelabComAu::Container.boot! :config
IcelabComAu::Container.register "postmark", Postmark::ApiClient.new(IcelabComAu::Container["config"].postmark_api_key)
