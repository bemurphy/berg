require "berg/import"

module Berg
  class Mailer
    include Berg::Import("logger", "postmark")

    def deliver(mail)
      logger.debug("[Berg::Mailer] delivering: #{mail.inspect}")
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
