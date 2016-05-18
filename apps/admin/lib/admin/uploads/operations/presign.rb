require "admin/import"
require "securerandom"
require "openssl"

module Admin
  module Uploads
    module Operations
      class Presign
        include Dry::ResultMatcher.for(:call)

        def call()
          uuid = SecureRandom.uuid
          expiration = (Time.now + 60*60*3).to_i

          payload = {
            url: "#{attache_host}/upload",
            uuid: uuid,
            expiration: expiration,
            hmac: OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha1"), attache_secret_key, "#{uuid}#{expiration}"),
          }

          Right(payload)
        end

        private

        def attache_host
          Berg::Container["config"].attache_uploads_base_url
        end

        def attache_secret_key
          Berg::Container["config"].attache_secret_key
        end
      end
    end
  end
end
