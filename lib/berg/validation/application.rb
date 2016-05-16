require 'i18n'
require "dry-validation"

module Berg
  module Validation
    Application = Dry::Validation.Schema do

      configure do
        config.messages = :i18n
      end

      required(:session_secret).maybe
      required(:database_url).maybe
      required(:assets_server_url).maybe
      required(:admin_url).maybe
      required(:precompiled_assets).maybe
      required(:precompiled_assets_host).maybe
      required(:app_mailer_from_email).maybe
      required(:admin_mailer_from_email).maybe
      required(:bugsnag_api_key).maybe
      required(:postmark_api_key).maybe
      required(:basic_auth_user).maybe
      required(:basic_auth_password).maybe

      rule(precompiled_assets: [:precompiled_assets, :precompiled_assets_host]) do |precompiled_assets, precompiled_assets_host|
        precompiled_assets.eql?(true).then(precompiled_assets_host.filled?)
      end
    end
  end
end
