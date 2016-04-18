require "icelab_com_au/import"

module IcelabComAu
  class Mailer
    include IcelabComAu::Import("logger", "postmark")

    def deliver(mail)
      logger.debug("[IcelabComAu::Mailer] delivering: #{mail.inspect}")
      postmark.deliver(mail.to_h.merge(from: from))
    end

    private

    def from
      options.app_mailer_from_email
    end

    def options
      Container["config"]
    end
  end
end
