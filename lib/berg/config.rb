require "types"
require "yaml"

module Berg
  class Config < Dry::Types::Struct
    RequiredString = Types::Strict::String.constrained(min_size: 1)

    attribute :admin_url, RequiredString
    attribute :admin_mailer_from_email, RequiredString

    attribute :database_url, RequiredString
    attribute :session_secret, RequiredString

    attribute :canonical_domain, Types::String
    attribute :assets_server_url, Types::String
    attribute :precompiled_assets, Types::Form::Bool # TODO: add .default(false) when dry-types allows it
    attribute :precompiled_assets_host, Types::String

    attribute :app_mailer_from_email, Types::String

    attribute :bugsnag_api_key, Types::String
    attribute :postmark_api_key, Types::String

    attribute :basic_auth_user, Types::String
    attribute :basic_auth_password, Types::String

    attribute :attache_uploads_base_url, Types::String
    attribute :attache_downloads_base_url, Types::String
    attribute :attache_secret_key, Types::String

    def self.load(root, name, env)
      path = root.join("config").join("#{name}.yml")
      yaml = File.exist?(path) ? YAML.load_file(path) : {}

      config = schema.keys.inject({}) { |memo, key|
        value = ENV.fetch(
          key.to_s.upcase,
          yaml.fetch(env.to_s, {})[key.to_s]
        )

        memo[key] = value
        memo
      }

      new(config)
    end
  end
end
